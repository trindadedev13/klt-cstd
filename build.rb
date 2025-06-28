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
    end
  end
end

FileUtils.mkdir_p("build")

NO_STD_ARGS = "-nostdlib -nodefaultlibs"

asm_files = Dir.glob("src/asm/#{arch}/**")
asm_files.each do |asm_file|
  out_filename = asm_file.split("/").last.sub(".s", ".o")
  run("gcc #{NO_STD_ARGS} -c -fPIC #{asm_file} -o build/#{out_filename}")
end

out_files = Dir.glob("build/*.o").join(" ")
run("gcc #{NO_STD_ARGS} -nostartfiles -Iinclude/ src/main.c #{out_files}")
FileUtils.mv("a.out", "build/main")

if run
  out_dir = ENV["HOME"] + "/temp/kltstd"

  FileUtils.mkdir_p(out_dir)
  FileUtils.cp("build/main", "#{out_dir}/main");
  run("chmod +x #{out_dir}/main")
  run("#{out_dir}/main")
end