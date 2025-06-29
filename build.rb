require 'fileutils'
require 'rbconfig'

def run(cmd)
  system(cmd) or abort("Failed to run #{cmd}")
end

def help()
  puts "Klt-CStd Buildscript"
  puts "--run  or -r   | Run after build."
  puts "--help or -h   | Shows helps."
  exit 1
end

sarch = RbConfig::CONFIG['host_cpu']

gcc_sub_args = []

arch = case sarch
  when "x86"     then :x86
  when "x86_64"  then :x86_64
  when "aarch64" then :aarch64
  when "i686"    then :arm
  else           :unknown
end

if arch == :unknown
  puts "Unknown architeture"
  exit(1)
end

puts "Building in #{arch}"

run = false

if ARGV.length >= 1
  ARGV.each do |arg|
    case arg
      when "-h", "--help"
        help()
      when "-r", "--run"
        run = true
      when "-as", "--asan"
        gcc_sub_args.push("-fsanitize=address")
    end
  end
end

FileUtils.mkdir_p("build")

FNO = "-fno-builtin-exit -fno-builtin-printf"
BASE_C_ARGS = "-std=c89 -nostdlib -nodefaultlibs"

asm_files = Dir.glob("src/asm/#{arch}/*.s")
asm_files.each do |asm_file|
  out_filename = asm_file.split("/").last.sub(".s", ".o")
  run("gcc #{BASE_C_ARGS} -c -fPIC #{asm_file} -o build/#{out_filename}")
end

c_srcs = Dir.glob("src/*.c").join(" ")
out_files = Dir.glob("build/*.o").join(" ")

gcc_sub_args_str = gcc_sub_args.join(" ")
run("gcc #{gcc_sub_args_str} #{BASE_C_ARGS} #{FNO} -nostartfiles -Iinclude/ #{c_srcs} #{out_files}")
FileUtils.mv("a.out", "build/main")

if run
  out_dir = ENV["HOME"] + "/temp/kltstd"

  FileUtils.mkdir_p(out_dir)
  FileUtils.cp("build/main", "#{out_dir}/main");
  run("chmod +x #{out_dir}/main")
  run("#{out_dir}/main")
end