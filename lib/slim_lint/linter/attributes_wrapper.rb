# frozen_string_literal: true

module SlimLint
  # Checks for missing or superfluous spacing before and after control statements.
  class Linter::AttributesWrapper < Linter
    include LinterRegistry

    STYLES = {
      :round  => ['\(', '\)'],
      :curly  => ['\{', '\}'],
      :square => ['\[', '\]'],
      :none   => [' ', ''],
      :any    => ['[\(\{\[]', '[\)\}\]]']
    }
    WRAPPER_START = '\A\s*[\w\.#][\w\.#-]*'
    WRAPPER_ANY = '.*'
    WRAPPER_END = '.*\z'
    ATTRIBUTES_REGEX = Regexp.new(WRAPPER_START + '( .*?=|\(|\{|\[).+')

    on_start do |_sexp|
      style = config.fetch('style', 'none').to_sym
      dummy_node = Struct.new(:line)

      document.source_lines.each_with_index do |line, index|
        # whether the line contains any attributes at all
        next unless line =~ ATTRIBUTES_REGEX
        next if line =~ line_regex(style)

        report_lint(dummy_node.new(index + 1), message(style))
      end
    end

    private

    def line_regex(style)
      @line_regex ||= Regexp.new(
        WRAPPER_START +
        STYLES[style].first +
        WRAPPER_ANY +
        STYLES[style].last +
        WRAPPER_END
      )
    end

    def message(style)
      message = 'Should '
      message + case style
                when :none
                  'not have any attribute wrapper characters'
                when :any
                  'wrap attributes in either (), [] or {}'
                else
                  "wrap attributes in #{STYLES[style].first.tr('\\', '')} and #{STYLES[style].last.tr('\\', '')}"
                end
    end

  end
end
