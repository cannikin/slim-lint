# frozen_string_literal: true

require 'spec_helper'

describe SlimLint::Linter::AttributesWrapper do
  include_context 'linter'

  context 'element with attributes' do

    context "when config style is 'none'" do

      let(:config) do
        SlimLint::ConfigurationLoader.load_hash({
          'linters' => {
            'AttributesWrapper' => {
              'enabled' => true,
              'style' => 'none'
            }
          }
        }).for_linter(described_class)
      end

      context "with no attribute wrapper" do

        context "with HTML only" do

          context 'attribute with no value' do
            let(:slim) { 'div data-foo' }

            it { should_not report_lint }
          end

          context 'tag with class shortcut' do
            let(:slim) { 'div.foo data-foo="bar"' }

            it { should_not report_lint }
          end

          context 'tag with id shortcut' do
            let(:slim) { 'div#foo data-foo="bar"' }

            it { should_not report_lint }
          end

          context 'tag with id and class shortcut' do
            let(:slim) { 'div#foo.bar data-foo="bar"' }

            it { should_not report_lint }
          end

          context 'tag with numbers' do
            let(:slim) { 'h1 data-foo="bar"' }

            it { should_not report_lint }
          end

          context 'attribute single quoted value' do
            let(:slim) { "div data-foo='bar'" }

            it { should_not report_lint }
          end

          context 'leading whitespace' do
            let(:slim) { '  div data-foo="bar"' }

            it { should_not report_lint }
          end

          context 'with text' do
            let(:slim) { 'div data-foo="bar" Foobar' }

            it { should_not report_lint }
          end

          context 'with output' do

            context 'with leading whitespace' do
              let(:slim) { 'div data-foo="bar" = "Foobar"' }

              it { should_not report_lint }
            end

            context 'without leading whitespace' do
              let(:slim) { 'div data-foo="bar"= "Foobar"' }

              it { should_not report_lint }
            end

          end

          context "with interpolation inside attribute values" do

            context "ruby-style in attribute value" do
              let(:slim) { 'div data-foo="#{bar}"= "Foobar"' }

              it { should_not report_lint }
            end

            context "method call as attribute value" do
              let(:slim) { 'div data-foo=bar= "Foobar"' }

              it { should_not report_lint }
            end

          end

        end

      end

      context "with round attribute wrapper" do

        context "with HTML only" do

          context 'attribute with no value' do
            let(:slim) { 'div(data-foo)' }

            it { should report_lint }
          end

          context 'tag with class shortcut' do
            let(:slim) { 'div.foo(data-foo="bar")' }

            it { should report_lint }
          end

          context 'tag with id shortcut' do
            let(:slim) { 'div#foo(data-foo="bar")' }

            it { should report_lint }
          end

          context 'tag with id and class shortcut' do
            let(:slim) { 'div#foo.bar(data-foo="bar")' }

            it { should report_lint }
          end

          context 'tag with numbers' do
            let(:slim) { 'h1(data-foo="bar")' }

            it { should report_lint }
          end

          context 'attribute with value, double quotes' do
            let(:slim) { 'div(data-foo="bar")' }

            it { should report_lint }
          end

          context 'attribute with value, single quotes' do
            let(:slim) { "div(data-foo='bar')" }

            it { should report_lint }
          end

          context 'leading whitespace' do
            let(:slim) { '  div(data-foo="bar")' }

            it { should report_lint }
          end

          context 'with text' do
            let(:slim) { 'div(data-foo="bar") Foobar' }

            it { should report_lint }
          end

        end

        context 'with output' do

          context 'with leading whitespace' do
            let(:slim) { 'div(data-foo="bar") = "Foobar"' }

            it { should report_lint }
          end

          context 'without leading whitespace' do
            let(:slim) { 'div(data-foo="bar")= "Foobar"' }

            it { should report_lint }
          end

        end

        context "with interpolation inside attribute values" do

          context "ruby-style in attribute value" do
            let(:slim) { 'div(data-foo="#{bar}")= "Foobar"' }

            it { should report_lint }
          end

          context "method call as attribute value" do
            let(:slim) { 'div(data-foo=bar)= "Foobar"' }

            it { should report_lint }
          end

        end

      end

      context "with square attribute wrapper" do

        context "with HTML only" do

          context 'attribute with no value' do
            let(:slim) { 'div[data-foo]' }

            it { should report_lint }
          end

        end

      end

      context "with curly attribute wrapper" do

        context "with HTML only" do

          context 'attribute with no value' do
            let(:slim) { 'div{data-foo}' }

            it { should report_lint }
          end

        end

        context "with interpolation inside attribute values" do

          context "ruby-style in attribute value" do
            let(:slim) { 'div{data-foo="#{bar}"}= "Foobar"' }

            it { should report_lint }
          end

        end

      end

    end

    context "when config style is 'round'" do

      let(:config) do
        SlimLint::ConfigurationLoader.load_hash({
          'linters' => {
            'AttributesWrapper' => {
              'enabled' => true,
              'style' => 'round'
            }
          }
        }).for_linter(described_class)
      end

      context "with no attribute wrapper" do

        context "with HTML only" do

          context 'attribute with no value' do
            let(:slim) { 'div data-foo' }

            it { should_not report_lint }
          end

          context 'tag with class shortcut' do
            let(:slim) { 'div.foo data-foo="bar"' }

            it { should report_lint }
          end

          context 'tag with id shortcut' do
            let(:slim) { 'div#foo data-foo="bar"' }

            it { should report_lint }
          end

          context 'tag with id and class shortcut' do
            let(:slim) { 'div#foo.bar data-foo="bar"' }

            it { should report_lint }
          end

          context 'tag with numbers' do
            let(:slim) { 'h1 data-foo="bar"' }

            it { should report_lint }
          end

          context 'attribute single quoted value' do
            let(:slim) { "div data-foo='bar'" }

            it { should report_lint }
          end

          context 'leading whitespace' do
            let(:slim) { '  div data-foo="bar"' }

            it { should report_lint }
          end

          context 'with text' do
            let(:slim) { 'div data-foo="bar" Foobar' }

            it { should report_lint }
          end

        end

        context 'with output' do

          context 'with leading whitespace' do
            let(:slim) { 'div data-foo="bar" = "Foobar"' }

            it { should report_lint }
          end

          context 'without leading whitespace' do
            let(:slim) { 'div data-foo="bar"= "Foobar"' }

            it { should report_lint }
          end

        end

        context "with interpolation inside attribute values" do

          context "ruby-style in attribute value" do
            let(:slim) { 'div data-foo="#{bar}"= "Foobar"' }

            it { should report_lint }
          end

          context "method call as attribute value" do
            let(:slim) { 'div data-foo=bar= "Foobar"' }

            it { should report_lint }
          end

        end

      end

      context "with round attribute wrapper" do

        context "with HTML only" do

          context 'attribute with no value' do
            let(:slim) { 'div(data-foo)' }

            it { should_not report_lint }
          end

          context 'tag with class shortcut' do
            let(:slim) { 'div.foo(data-foo="bar")' }

            it { should_not report_lint }
          end

          context 'attributes wrap onto the next line' do
            let(:slim) { "div.foo(\n  data-foo='bar'\n)" }

            it { should_not report_lint }
          end

          context 'tag with id shortcut' do
            let(:slim) { 'div#foo(data-foo="bar")' }

            it { should_not report_lint }
          end

          context 'tag with id and class shortcut' do
            let(:slim) { 'div#foo.bar(data-foo="bar")' }

            it { should_not report_lint }
          end

          context 'tag with numbers' do
            let(:slim) { 'h1(data-foo="bar")' }

            it { should_not report_lint }
          end

          context 'attribute with value, double quotes' do
            let(:slim) { 'div(data-foo="bar")' }

            it { should_not report_lint }
          end

          context 'attribute with value, single quotes' do
            let(:slim) { "div(data-foo='bar')" }

            it { should_not report_lint }
          end

          context 'leading whitespace' do
            let(:slim) { '  div(data-foo="bar")' }

            it { should_not report_lint }
          end

          context 'with text' do
            let(:slim) { 'div(data-foo="bar") Foobar' }

            it { should_not report_lint }
          end

        end

        context 'with output' do

          context 'with leading whitespace' do
            let(:slim) { 'div(data-foo="bar") = "Foobar"' }

            it { should_not report_lint }
          end

          context 'without leading whitespace' do
            let(:slim) { 'div(data-foo="bar")= "Foobar"' }

            it { should_not report_lint }
          end

        end

        context "with interpolation inside attribute values" do

          context "ruby-style in attribute value" do
            let(:slim) { 'div(data-foo="#{bar}")= "Foobar"' }

            it { should_not report_lint }
          end

          context "method call as attribute value" do
            let(:slim) { 'div(data-foo=bar)= "Foobar"' }

            it { should_not report_lint }
          end

        end

      end

    end

    context "when config style is 'square'" do

      let(:config) do
        SlimLint::ConfigurationLoader.load_hash({
          'linters' => {
            'AttributesWrapper' => {
              'enabled' => true,
              'style' => 'square'
            }
          }
        }).for_linter(described_class)
      end

      context "with no attribute wrapper" do

        context "with HTML only" do

          context 'attribute with no value' do
            let(:slim) { 'div data-foo' }

            it { should_not report_lint }
          end

        end

      end

      context "with round attribute wrapper" do

        context "with HTML only" do

          context 'attribute with no value' do
            let(:slim) { 'div(data-foo)' }

            it { should report_lint }
          end

        end

      end

      context "with square attribute wrapper" do

        context "with HTML only" do

          context 'attribute with no value' do
            let(:slim) { 'div[data-foo]' }

            it { should_not report_lint }
          end

        end

        context "with interpolation inside attribute values" do

          context "ruby-style in attribute value" do
            let(:slim) { 'div[data-foo="#{bar}"]= "Foobar"' }

            it { should_not report_lint }
          end

        end

      end

      context "with curly attribute wrapper" do

        context "with HTML only" do

          context 'attribute with no value' do
            let(:slim) { 'div{data-foo}' }

            it { should report_lint }
          end

        end

        context "with interpolation inside attribute values" do

          context "ruby-style in attribute value" do
            let(:slim) { 'div{data-foo="#{bar}"}= "Foobar"' }

            it { should report_lint }
          end

        end

      end

    end

    context "when config style is 'curly'" do

      let(:config) do
        SlimLint::ConfigurationLoader.load_hash({
          'linters' => {
            'AttributesWrapper' => {
              'enabled' => true,
              'style' => 'curly'
            }
          }
        }).for_linter(described_class)
      end

      context "with no attribute wrapper" do

        context "with HTML only" do

          context 'attribute with no value' do
            let(:slim) { 'div data-foo' }

            it { should_not report_lint }
          end

        end

        context "with interpolation inside attribute values" do

          context "ruby-style in attribute value" do
            let(:slim) { 'div data-foo="#{bar}" = "Foobar"' }

            it { should report_lint }
          end

        end

      end

      context "with round attribute wrapper" do

        context "with HTML only" do

          context 'attribute with no value' do
            let(:slim) { 'div(data-foo)' }

            it { should report_lint }
          end

        end

        context "with interpolation inside attribute values" do

          context "ruby-style in attribute value" do
            let(:slim) { 'div(data-foo="#{bar}")= "Foobar"' }

            it { should report_lint }
          end

        end

      end

      context "with square attribute wrapper" do

        context "with HTML only" do

          context 'attribute with no value' do
            let(:slim) { 'div[data-foo]' }

            it { should report_lint }
          end

        end

        context "with interpolation inside attribute values" do

          context "ruby-style in attribute value" do
            let(:slim) { 'div[data-foo="#{bar}"]= "Foobar"' }

            it { should report_lint }
          end

        end

      end

      context "with curly attribute wrapper" do

        context "with HTML only" do

          context 'attribute with no value' do
            let(:slim) { 'div{data-foo}' }

            it { should_not report_lint }
          end

        end

        context "with interpolation inside attribute values" do

          context "ruby-style in attribute value" do
            let(:slim) { 'div{data-foo="#{bar}"}= "Foobar"' }

            it { should_not report_lint }
          end

        end

      end

    end

  end

  context 'element without attributes' do

    context "when config style is 'none'" do

      let(:config) do
        SlimLint::ConfigurationLoader.load_hash({
          'linters' => {
            'AttributesWrapper' => {
              'enabled' => true,
              'style' => 'none'
            }
          }
        }).for_linter(described_class)
      end

      context 'element only' do
        let(:slim) { 'div' }

        it { should_not report_lint }
      end

      context 'element with text' do
        let(:slim) { 'div Foobar' }

        it { should_not report_lint }
      end

      context 'element with html entities' do
        let(:slim) { 'div &mdash;' }

        it { should_not report_lint }
      end

      context 'element with other characters' do
        let(:slim) { 'div +' }

        it { should_not report_lint }
      end

      context 'element with a class shortcut' do
        let(:slim) { '  div.foo' }

        it { should_not report_lint }
      end

      context 'element with an id shortcut' do
        let(:slim) { 'div#bar' }

        it { should_not report_lint }
      end

      context 'element with both class and id shortcuts' do
        let(:slim) { '  div#foo.bar' }

        it { should_not report_lint }
      end

      context 'only class shortcut' do
        let(:slim) { '.foo' }

        it { should_not report_lint }
      end

      context 'only id shortcut' do
        let(:slim) { '  #bar' }

        it { should_not report_lint }
      end

      context 'id and class shortcut' do
        let(:slim) { '#bar.foo' }

        it { should_not report_lint }
      end

      context 'multiple class shortcuts' do
        let(:slim) { '.foo.bar' }

        it { should_not report_lint }
      end

      context 'control code' do
        let(:slim) { '- if foobar' }

        it { should_not report_lint }
      end

      context 'output only' do
        let(:slim) { '= "Foobar"' }

        it { should_not report_lint }
      end

      context 'output after element' do
        let(:slim) { 'div.foo= "Foobar"' }

        it { should_not report_lint }
      end

    end

    context "when config style is 'round'" do

      let(:config) do
        SlimLint::ConfigurationLoader.load_hash({
          'linters' => {
            'AttributesWrapper' => {
              'enabled' => true,
              'style' => 'round'
            }
          }
        }).for_linter(described_class)
      end

      context 'element only' do
        let(:slim) { 'div' }

        it { should_not report_lint }
      end

      context 'element with text' do
        let(:slim) { 'div Foobar' }

        it { should_not report_lint }
      end

      context 'element with html entities' do
        let(:slim) { 'div &mdash;' }

        it { should_not report_lint }
      end

      context 'element with other characters' do
        let(:slim) { 'div +' }

        it { should_not report_lint }
      end

      context 'element with a class shortcut' do
        let(:slim) { '  div.foo' }

        it { should_not report_lint }
      end

      context 'element with an id shortcut' do
        let(:slim) { 'div#bar' }

        it { should_not report_lint }
      end

      context 'element with both class and id shortcuts' do
        let(:slim) { '  div#foo.bar' }

        it { should_not report_lint }
      end

      context 'only class shortcut' do
        let(:slim) { '.foo' }

        it { should_not report_lint }
      end

      context 'only id shortcut' do
        let(:slim) { '  #bar' }

        it { should_not report_lint }
      end

      context 'id and class shortcut' do
        let(:slim) { '#bar.foo' }

        it { should_not report_lint }
      end

      context 'multiple class shortcuts' do
        let(:slim) { '.foo.bar' }

        it { should_not report_lint }
      end

      context 'control code' do
        let(:slim) { '- if foobar' }

        it { should_not report_lint }
      end

      context 'output only' do
        let(:slim) { '= "Foobar"' }

        it { should_not report_lint }
      end

      context 'output after element' do
        let(:slim) { 'div.foo= "Foobar"' }

        it { should_not report_lint }
      end

    end

  end

end
