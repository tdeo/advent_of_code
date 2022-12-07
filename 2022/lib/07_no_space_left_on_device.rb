# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class NoSpaceLeftOnDevice
  extend T::Sig

  class Folder < T::Struct
    const :name, String
    const :parent, T.nilable(Folder)
    prop :children, T::Array[T.any(File, Folder)], default: []
    prop :total_size, T.nilable(Integer)
  end

  class File < T::Struct
    const :name, String
    const :parent, Folder
    const :size, Integer
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @root = T.let(Folder.new(name: '/'), Folder)
    @cwd = T.let(@root, Folder)
    build_tree
    compute_size
  end

  sig { void }
  def build_tree
    @input.split("\n").each do |line|
      if line.start_with?('$ ')
        execute_command(T.must(line[2..]))
      else
        a, name = line.split
        @cwd.children << if a == 'dir'
                           Folder.new(
                             name: T.must(name),
                             parent: @cwd,
                           )
                         else
                           File.new(
                             name: T.must(name),
                             parent: @cwd,
                             size: a.to_i,
                           )
                         end
      end
    end
  end

  sig { params(entry: String).void }
  def execute_command(entry)
    command, arg = entry.split

    case command
    when 'cd'
      case arg
      when '/' then @cwd = @root
      when '..'
        @cwd = T.must(@cwd.parent)
      else
        child = @cwd.children.find { _1.is_a?(Folder) && _1.name == arg }
        raise ArgumentError, entry unless child.is_a?(Folder)

        @cwd = child

      end
    when 'ls'
      # Do nothing
    else
      raise ArgumentError, entry
    end
  end

  sig { params(folder: Folder).void }
  def compute_size(folder = @root)
    folder.children.each do |child|
      compute_size(child) if child.is_a?(Folder)
    end

    folder.total_size = folder.children.sum do |child|
      case child
      when Folder then child.total_size
      when File then child.size
      else T.absurd(child)
      end
    end
  end

  sig { params(folder: Folder, _blk: T.proc.params(folder: Folder).void).void }
  def each_folder(folder = @root, &_blk)
    folder.children.each do |child|
      each_folder(child) { yield _1 } if child.is_a?(Folder)
    end
    yield folder
  end

  sig { returns(Integer) }
  def part1
    total = 0
    each_folder do |folder|
      total += T.must(folder.total_size) if T.must(folder.total_size) <= 100_000
    end
    total
  end

  sig { returns(Integer) }
  def part2
    space_required = T.must(@root.total_size) - 40_000_000
    best_size = T.must(@root.total_size)
    each_folder do |folder|
      next if T.must(folder.total_size) < space_required
      next if T.must(folder.total_size) > best_size

      best_size = T.must(folder.total_size)
    end
    best_size
  end
end
