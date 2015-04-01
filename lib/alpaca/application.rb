require 'alpaca/log'
require 'alpaca/solutions'

module Alpaca
  # Class *Application* provides methods that can
  # be used by CLI and from REPL sessions
  class Application
    DEFAULT_SOLUTIONS_PATTERN = ['**/*.sln', '**/Assets']

    include Log

    # Runs compile against each found solution by pattern
    #
    # +[pattern]+:: pattern to find a solution(Array can be used)
    # +[debug]+:: switch to compile solution in debug mode (false by default)
    def compile(pattern = DEFAULT_SOLUTIONS_PATTERN, debug = false)
      header 'Compile'
      Solutions.each(pattern) do |solution|
        log solution
        solution.compile(debug)
      end
    end

    # Runs tests against each found solution by pattern
    #
    # +[pattern]+:: pattern to find a solution(Array can be used)
    # +[debug]+:: switch to run solution tests in debug mode (false by default)
    # +[coverage]+:: switch to run coverage (false by default)
    # +[category]+:: tests category - smoke, unit, service... (all by default)
    def test(pattern = DEFAULT_SOLUTIONS_PATTERN,
             debug = false,
             coverage = false,
             category = 'all')
      header 'Test'
      Solutions.each(pattern) do |solution|
        log solution
        solution.test(debug, coverage, category)
      end
    end

    def report(pattern = DEFAULT_SOLUTIONS_PATTERN, category = 'all')
      header 'Report'
      Solutions.each(pattern) do |solution|
        log solution
        solution.report(category)
      end
    end

    def pack(pattern = DEFAULT_SOLUTIONS_PATTERN)
      header 'Pack'
      Solutions.each(pattern) do |solution|
        log solution
        solution.pack
      end
    end

    def release(pattern = DEFAULT_SOLUTIONS_PATTERN, push = true)
      header 'Release'
      Solutions.each(pattern) do |solution|
        log solution
        solution.release(push)
      end
    end

    def push(pattern = DEFAULT_SOLUTIONS_PATTERN, force = false)
      header 'Push'
      Solutions.each(pattern) do |solution|
        log solution
        solution.push(force)
      end
    end

    def configure_global(properties)
      header 'Configure'
      Configuration.set(properties)
    end

    def configure_local(pattern = DEFAULT_SOLUTIONS_PATTERN, properties)
      header 'Configure'
      Solutions.each(pattern) do |solution|
        log solution
        Configuration.new(solution).set(properties)
      end
    end
  end
end
