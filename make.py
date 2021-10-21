import subprocess
import sys
import shutil
import os
import re
import fileinput
import json
import glob

from shutil import copyfile
from pathlib import Path

def identify_src_files(config):
    ada_files = glob.glob(os.path.join(os.getcwd(), config['module_sources_path'], "*.ads"))
    c_files = glob.glob(os.path.join(os.getcwd(), config['module_sources_path'], "*.c"))
    return ada_files + c_files
    
def generate(config):

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

    def find_objects():
        files = identify_src_files(config)
        objects = []
        for file in files:
            objects.append("obj/" + Path(file).stem + ".o")

        return objects

    def generate_makefile(src, dst, module_name, expanded_module_objects, makefile_location):
        filepath = copy_and_rename_file(src, dst, "Makefile")
        replace_in_file(filepath, "<module_name>", module_name)

        if len(expanded_module_objects) == 0:
            expanded_module_objects = ""
        replace_in_file(filepath, "<expanded_module_objects>", expanded_module_objects)

        if config["target_architecture"] == "arm32":
            replace_in_file(filepath, "<target_architecture>", "arm")
        else:
            replace_in_file(filepath, "<target_architecture>", config['target_architecture'])

        cross_compile_path_and_prefix = os.path.join(config['cross_compiler_path'], config['cross_compiler_binary_prefix'])
        replace_in_file(filepath, "<cross_compile_path_and_prefix>", cross_compile_path_and_prefix)
        replace_in_file(filepath, "<kernel_sources_path>", config['kernel_sources_path'])
        replace_in_file(filepath, "<makefile_location>", makefile_location)
        
        replace_in_file(filepath, "<kbuild_path>", "./")

    def find_gcc_options():

        def filter_options(line):
            magic_string = "cmd_" + os.getcwd() + "/tmp/basic_kernel_module.o :="
            line = line.replace(magic_string, '')
            line = line.replace("basic_kernel_module", config["module_name"])
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
                    options[index] = option.replace(relative_include, "-I" + config['kernel_sources_path'] + "/")
                options[index] = "\"" + options[index] + "\""
                
            relative = "./include"
            for index, option in enumerate(options):
                if relative in option:
                    options[index] = option.replace(relative, config['kernel_sources_path'] + "/include")

            for index, option in enumerate(options):
                for unwanted_gcc_option in config["unwanted_gcc_options"]:
                    if "\"{}\"".format(unwanted_gcc_option) == option:
                        del options[index]

            return options
 
        os.makedirs("tmp", exist_ok=True)
        copyfile("templates/basic_kernel_module.c", "tmp/basic_kernel_module.c") 
        generate_makefile("templates/makefile_template", "tmp", "basic_kernel_module", [], os.path.join(os.getcwd(), "tmp"))
        remove_line_from_file("tmp/Makefile", 2)
        os.environ["ENV_PREFIX"] = config['cross_compiler_path']
        output, error = subprocess.Popen(['make'], stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd="./tmp").communicate()
        print(output)
        print(error)

        with open("tmp/.basic_kernel_module.o.cmd") as f:
            lines = f.read()
            first = lines.split('\n', 1)[0]
            return filter_options(first)

    def find_gnat_options():
        options = config['wanted_gnat_options']
        for index, option in enumerate(options):
            options[index] = "\"" + options[index] + "\""
        return options

    def generate_gpr_file():
        filepath = copy_and_rename_file("templates/driver_template.gpr", config['module_path'], config['module_name'] + ".gpr")
        replace_in_file(filepath, "<module_name>", config['module_name'])

        target_architecture = None
        if config["target_architecture"] == "arm32":
            target_architecture = "\"arm-elf\""
        if config["target_architecture"] == "arm64":
            target_architecture = "\"aarch64-linux\""
        replace_in_file(filepath, "<target_architecture>", target_architecture)

        replace_in_file(filepath, "<module_sources_path>", "\"" + str(os.path.relpath(config['module_sources_path'], config['module_path'])) + "\"")
        replace_in_file(filepath, "<module_build_path>", "\"" + str(os.path.relpath(config['module_build_path'], config['module_path'])) + "\"")

        gnat_options = find_gnat_options()
        formatted_gnat_options = ",\n".join(gnat_options)
        replace_in_file(filepath, "<wanted_gnat_options>", formatted_gnat_options)

        gcc_options = find_gcc_options()
        formatted_gcc_options = ",\n".join(gcc_options)
        replace_in_file(filepath, "<parsed_make_compilation_options>", formatted_gcc_options) 
        
    generate_gpr_file()
    generate_makefile("templates/makefile_template", config['module_path'], config['module_name'], " ".join(find_objects()), os.path.join(os.getcwd(), config['module_path']))
    #shutil.rmtree("tmp", ignore_errors=True)

def build(config):

    def compile_module_files():
        cmd = [os.path.join(config["cross_compiler_path"], "gprbuild"), config['module_name'] + ".gpr"]
        output, error = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=os.path.join(os.getcwd(), config['module_path'])).communicate()
        print(error)

    def create_cmd_o_files():
        files = identify_src_files(config)
        for file in files:
            filepath = "obj/.{}.o.cmd".format(Path(file).stem)
            output, error = subprocess.Popen(["touch", filepath], stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=os.path.join(os.getcwd(), config['module_path'])).communicate()
            print(error)

    def build_kernel_module():
        output, error = subprocess.Popen(["make"], stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=os.path.join(os.getcwd(), config['module_path'])).communicate()
        print(error)

    os.environ["ENV_PREFIX"] = config['cross_compiler_path']
    compile_module_files()
    create_cmd_o_files()
    build_kernel_module()

def clean(config):

    def remove_by_extension(path, extension):
        items = os.listdir(path)
        for item in items:
            if item.endswith(extension):
                os.remove(os.path.join(path, item))
    
    def remove_file(filepath):
        try:
            os.remove(filepath)
        except OSError:
            pass
    
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
    shutil.rmtree("tmp", ignore_errors=True)

    remove_all_files(config['module_path'])
    shutil.rmtree(config['module_build_path'], ignore_errors=True)

    remove_file(os.path.join(config['module_path'], "Makefile"))

def get_parameter(params, pattern):
    for p in params:
        res = re.sub(pattern+":", "", p)
        if res != p:
            return res
    return None

if __name__ == "__main__":

    available_funcs = {
        "generate": generate,
        "build": build,
        "clean": clean,
        "help": help
    }

    def help():
        help_messages = [
            "Call convention:",
            "\t" + "$ python script function_name param(0):value(0) ... param(N-1):value(N-1)",
            "\t" + "eg: $ python make.py build config:config.json",
            "Avalaible function_name:",
            *("\t" + avail_func for avail_func in list(available_funcs.keys()))]

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
                config["cross_compiler_binary_prefix"] = platform_config["cross_compiler_binary_prefix"]
                config["unwanted_gcc_options"] = platform_config["unwanted_gcc_options"]
                config["wanted_gnat_options"] = platform_config["wanted_gnat_options"]
        except:
            print("Loading the platforms.json failed.")

        return config

    function_name = sys.argv[1]
    function_name = function_name.lower()

    config_filename = get_parameter(sys.argv, "config")
    if config_filename != None:
        config = build_config_object(config_filename)

        for func in available_funcs:
            if func == function_name:
                available_funcs[func](config)
    else:
        help(None)