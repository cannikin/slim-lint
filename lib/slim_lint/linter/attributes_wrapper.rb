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

    on [:html, :tag, anything,
         [:html, :attrs]] do |sexp|
      style = config.fetch('style', 'none').to_sym
      line = document.source_lines[sexp.line - 1].chomp

      non_static_attributes = sexp[3].collect do |attr|
        attr if attr.is_a? SlimLint::Sexp and attr[3][0] != :static
      end.compact

      # ignore the line if all attributes are static
      next if non_static_attributes.empty?
      # regex for line containing attributes wrapper or not
      next if line =~ line_regex(style)

      report_lint(sexp, message(style))
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
