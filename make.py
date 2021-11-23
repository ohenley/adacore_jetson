from subprocess import Popen, PIPE
import sys
import shutil
import os
import re
import fileinput
import json
import glob
import inspect

from shutil import copyfile
from pathlib import Path

class Make:
    def __init__(self):
        pass

    def generate(self, config):

        def copy_and_rename_file(src, dst, filename):
            src_filepath = os.path.join(os.getcwd(), src)
            os.makedirs(os.path.join(os.getcwd(), dst), exist_ok=True)
            dst_filepath = os.path.join(os.getcwd(), dst, filename) 
            copyfile(src_filepath, dst_filepath) 
            return dst_filepath

        def replace_in_file(filepath, key, substitution_value):
            with fileinput.FileInput(filepath, inplace=True) as file:
               for line in file:
                   print(line.replace(key, substitution_value), end='')

        def remove_line_from_file(filepath, line_index):
            for line in fileinput.input(filepath, inplace=True):
                if fileinput.lineno() == line_index:
                    print("")
                else:
                    print(line)

        def generate_makefile(src, dst, module_name, makefile_location):
            filepath = copy_and_rename_file(src, dst, "Makefile")
            replace_in_file(filepath, "<module_name>", module_name)
            replace_in_file(filepath, "<expanded_module_objects>", "obj/bundle.o")
            replace_in_file(filepath, "<target_architecture>", config['target_architecture'])
            cross_compile_path_and_prefix = os.path.join(config['cross_toolchain_abspath'], config['cross_compiler_binary_prefix'])
            replace_in_file(filepath, "<cross_compile_path_and_prefix>", cross_compile_path_and_prefix)
            replace_in_file(filepath, "<kernel_sources_path>", config['kernel_sources_abspath'])
            replace_in_file(filepath, "<makefile_location>", makefile_location)

        def find_gcc_options():

            def filter_options(line):
                magic_string = "cmd_" + os.getcwd() + "/tmp/basic_module.o :="
                line = line.replace(magic_string, '')
                line = line.replace("basic_module", config["module_name"])
                line = line.replace("tmp", "src")
                line = line.replace("\'\"", "'")
                line = line.replace("\"\'", "'")
                line = re.sub(' +', ' ', line)
                options = line.split()
                options = options[2:]
                options = options[:-4]

                relative_include = "-I./"
                for index, option in enumerate(options):
                    if relative_include in option:
                        options[index] = option.replace(relative_include, "-I" + config['kernel_sources_abspath'] + "/")
                    options[index] = "\"" + options[index] + "\""

                relative = "./include"
                for index, option in enumerate(options):
                    if relative in option:
                        options[index] = option.replace(relative, config['kernel_sources_abspath'] + "/include")

                for index, option in enumerate(options):
                    for unwanted_gcc_option in config["unwanted_gcc_options"]:
                        if "\"{}\"".format(unwanted_gcc_option) == option:
                            del options[index]

                return options
    
            os.makedirs("tmp", exist_ok=True)
            copyfile("templates/basic_module.c", "tmp/basic_module.c") 
            generate_makefile("templates/makefile_template", "tmp", "basic_module", os.path.join(os.getcwd(), "tmp"))
            remove_line_from_file("tmp/Makefile", 2)
            os.environ["ENV_PREFIX"] = config['cross_toolchain_abspath']
            output, error = Popen(['make'], stdout=PIPE, stderr=PIPE, cwd="./tmp").communicate()
            print(output.decode("utf-8"))
            print(error.decode("utf-8"))

            with open("tmp/.basic_module.o.cmd") as f:
                lines = f.read()
                first = lines.split('\n', 1)[0]
                return filter_options(first)

        def find_gnat_options():
            options = config['wanted_gnat_options']
            for index, option in enumerate(options):
                options[index] = "\"" + options[index] + "\""
            return options

        def generate_gpr_file():
            filepath = copy_and_rename_file("templates/module_template.gpr", config['module_path'], config['module_name'] + ".gpr")

            replace_in_file(filepath, "<module_name>", config['module_name'])
            replace_in_file(filepath, "<target_architecture>", "\"" + config["architecture_alias"] + "\"")
            replace_in_file(filepath, "<module_sources_path>", "\"" + str(os.path.relpath(config['module_sources_path'], config['module_path'])) + "\"")
            replace_in_file(filepath, "<rts_path>", "\"" + str(os.path.join(os.getcwd(), config['rts_path'])) + "\"")

            gnat_options = find_gnat_options()
            formatted_gnat_options = ",\n".join(gnat_options)
            replace_in_file(filepath, "<wanted_gnat_options>", formatted_gnat_options)

            gcc_options = find_gcc_options()
            formatted_gcc_options = ",\n".join(gcc_options)
            replace_in_file(filepath, "<parsed_make_compilation_options>", formatted_gcc_options) 

        copyfile(os.path.join(os.getcwd(), "templates/gnat.adc"), os.path.join(os.getcwd(), config['module_path'], "gnat.adc"))
        generate_gpr_file()
        generate_makefile("templates/makefile_template", config['module_path'], config['module_name'], os.path.join(os.getcwd(), config['module_path']))

    def build(self, config, rts):

        def build_rts():
            cmd = [os.path.join(config["cross_toolchain_abspath"], "gprbuild"), "-v", "-f", "-g", os.path.join(os.getcwd(), config["rts_path"], "runtime_build.gpr")]

            output, error = Popen(cmd, stdout=PIPE, stderr=PIPE, cwd=os.path.join(os.getcwd(), config['module_path'])).communicate()
            print(output.decode("utf-8"))
            print(error.decode("utf-8"))

        def compile_module_files():
            cmd = [os.path.join(config["cross_toolchain_abspath"], "gprbuild"), "-v", "-f", "-g", os.path.join(os.getcwd(), config['module_path'], config['module_name'] + ".gpr")]

            output, error = Popen(cmd, stdout=PIPE, stderr=PIPE, cwd=os.path.join(os.getcwd(), config['module_path'])).communicate()
            print(output.decode("utf-8"))
            print(error.decode("utf-8"))


        def build_bundle_object():
            linker = os.path.join(config["cross_toolchain_abspath"], config["cross_compiler_binary_prefix"] + "ld")
            ada_module = os.path.join(os.getcwd(), config["module_path"], "lib/lib" + config["module_name"] + ".a")
            rts = os.path.join(os.getcwd(), config["rts_path"], "adalib", "libgnat.a")
            bundle = os.path.join(os.getcwd(), config['module_path'], "obj/bundle.o")
            cmd = [linker, "-i", "-o", bundle, "--whole-archive", ada_module, "--no-whole-archive", rts]

            output, error = Popen(cmd, stdout=PIPE, stderr=PIPE, cwd=os.path.join(os.getcwd(), config['module_path'])).communicate()
            print(output.decode("utf-8"))
            print(error.decode("utf-8"))

        def create_cmd_o_files():

            def identify_src_files(config):
                ada_files = glob.glob(os.path.join(os.getcwd(), config['module_sources_path'], "*.ads"))
                c_files = glob.glob(os.path.join(os.getcwd(), config['module_sources_path'], "*.c"))
                return ada_files + c_files

            files = identify_src_files(config)
            for file in files:
                filepath = "obj/.{}.o.cmd".format(Path(file).stem)
                output, error = Popen(["touch", filepath], stdout=PIPE, stderr=PIPE, cwd=os.path.join(os.getcwd(), config['module_path'])).communicate()
                print(output.decode("utf-8"))
                print(error.decode("utf-8"))

        def build_kernel_module():
            output, error = Popen(["make"], stdout=PIPE, stderr=PIPE, cwd=os.path.join(os.getcwd(), config['module_path'])).communicate()
            print(error.decode("utf-8"))
            print(output.decode("utf-8"))

        os.environ["ENV_PREFIX"] = config['cross_toolchain_abspath']
        if rts:
            build_rts()
        compile_module_files()
        build_bundle_object()
        create_cmd_o_files()
        build_kernel_module()

    def clean(self, config):
            
        def remove_all_files(dir):
            dir = Path(dir)
            for item in dir.iterdir():
                if not item.is_dir():
                    os.remove(item)

        def remove_dir_recursively(root, dir_to_remove):
            root = Path(root)
            for item in root.iterdir():
                if item.is_dir():
                    dir = os.path.basename(os.path.normpath(item))
                    if dir == dir_to_remove:
                        shutil.rmtree(item)
                    else:
                        remove_dir_recursively(item, dir_to_remove)


        remove_dir_recursively(os.getcwd(), ".tmp_versions")
        shutil.rmtree(os.path.join(os.getcwd(),"tmp"), ignore_errors=True)

        module_path = os.path.join(os.getcwd(), config['module_path'])

        remove_all_files(module_path)
        remove_all_files(os.path.join(module_path, "obj"))
        remove_all_files(os.path.join(module_path, "lib"))

        remove_all_files(os.path.join(os.getcwd(), config['rts_path'], "adalib"))
        remove_all_files(os.path.join(os.getcwd(), config['rts_path'], "obj"))

if __name__ == "__main__":

    def get_cmd_arguments(params):
        arguments = {}
        for p in params:
            result = p.split(':')
            arguments[result[0]] = result[1]
        return arguments

    def get_make_methods():
        return [func for func in dir(Make) if callable(getattr(Make, func)) and not func.startswith("__")]

    def get_methods_params(methods_list):
        methods_params = {}
        for method in methods_list:
            methods_params[method] = [p for p in inspect.signature(getattr(Make, method)).parameters if p != "self"]
        return methods_params
    
    def cmd_args_are_valid(cmd_arguments):
        for key in cmd_arguments:
            if key == "config":
                if not Path(cmd_arguments[key]).is_file():
                    print("ERROR: config file not valid")
                    return False
            if key == "rts":
                arg = cmd_arguments[key].lower()
                if arg == "yes" or arg == "true":
                    cmd_arguments[key] = True
                else:
                    cmd_arguments[key] = False
        return True

    def args_are_matching_params(function_name, cmd_arguments, methods_params):
        for param in methods_params[function_name]:
            if param not in cmd_arguments:
                print("ERROR: missing argument " + param)
                return False
        return True


    def help(methods_params):

        def func_description():
            descs = []
            for method in methods_params:
                desc = method + " with parameters: "
                for param in methods_params[method]:
                    desc = desc + param + ", "
                descs.append(desc)
            return descs

        help_messages = [
            "Call convention:",
            "\t" + "$ python script function_name param(0):value(0) ... param(N-1):value(N-1)",
            "\t" + "eg: $ python make.py build config:config.json rts:true",
            "Avalaible function_name:",
            *("\t" + avail_func for avail_func in func_description())
        ]

        for line in help_messages:
            print(line)

    
    def build_config_object(config_filename):
        config = None
        try:
            with open(config_filename, 'r') as f:
                config = json.load(f)
        except:
            print("Loading {} failed.".format(config_filename))

        try:
            with open(config["platform_definitions_filepath"], 'r') as g:
                platforms = json.load(g)
                platform_config = platforms[config["target_platform"]][config["target_architecture"]]
                config["architecture_alias"] = platform_config["architecture_alias"]
                config["cross_compiler_binary_prefix"] = platform_config["cross_compiler_binary_prefix"]
                config["unwanted_gcc_options"] = platform_config["unwanted_gcc_options"]
                config["wanted_gnat_options"] = platform_config["wanted_gnat_options"]
        except:
            print("Loading the platforms.json failed.")

        return config

    function_name = sys.argv[1].lower()
    cmd_arguments = get_cmd_arguments(sys.argv[2:])
    methods_params = get_methods_params(get_make_methods())
    args_valid = cmd_args_are_valid(cmd_arguments)
    args_match_params = args_are_matching_params(function_name, cmd_arguments, methods_params)

    if args_valid and args_match_params:
        cmd_arguments["config"] = build_config_object(cmd_arguments["config"])
        make = Make()
        func = getattr(make, function_name)
        try:
            func(*cmd_arguments.values())
        except Exception as e:
            exc_type, exc_obj, exc_tb = sys.exc_info()
            fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
            print(exc_type, fname, exc_tb.tb_lineno)
            help(methods_params)
    else:
        help(methods_params)
