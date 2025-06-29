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

arch = case RbConfig::CONFIG['host_cpu']
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

asmbuild_args = [
  "-nostdlib",
  "-nodefaultlibs",
  "-c -fPIC"
]

cbuild_args = [
  "-std=c89",
  "-nostdlib",
  "-nostartfiles",
  "-nodefaultlibs",
  "-fno-builtin",
  "-ffreestanding",
  "-static",
  "-Iinclude/"
]

run = false

if ARGV.length >= 1
  ARGV.each do |arg|
    case arg
      when "-h", "--help"
        help()
      when "-r", "--run"
        run = true
      when "-as", "--asan"
        cbuild_args.push("-fsanitize=address")
    end
  end
end

FileUtils.mkdir_p("build")

asm_files = Dir.glob("src/asm/#{arch}/*.s")
asm_files.each do |asm_file|
  out_filename = asm_file.split("/").last.sub(".s", ".o")
  asmbuild_args_str = asmbuild_args.join(" ")
  run("gcc #{asmbuild_args_str} #{asm_file} -o build/#{out_filename}")
end

c_srcs = Dir.glob("src/*.c").join(" ")
out_files = Dir.glob("build/*.o").join(" ")

cbuild_args_str = cbuild_args.join(" ")
run("gcc  #{cbuild_args_str} #{c_srcs} #{out_files}")
if File.exist?("a.out")
  FileUtils.mv("a.out", "build/main")
end

if run
  out_dir = ENV["HOME"] + "/temp/kltstd"

  FileUtils.mkdir_p(out_dir)
  FileUtils.cp("build/main", "#{out_dir}/main");
  run("chmod +x #{out_dir}/main")
  run("#{out_dir}/main")
end