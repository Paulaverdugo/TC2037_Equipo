# Module to highlight the syntax of a Python file.
# Authors: Paula Verdugo Márquez (A01026218) and Lucia Barrenechea (A01026249)
# Date: 30/05/2023

defmodule Syntaxhighlighter do
  # Function to highlight the syntax of a Python file.
  def highlight(file) do
    expanded_path = Path.expand(file)

    IO.puts("Reading file: #{expanded_path}")

    case File.read(expanded_path) do
      {:ok, text} ->
        highlighted_text = highlight_text(text)
        html_content = build_html_content(highlighted_text)
        File.write("example.html", html_content)

      {:error, reason} ->
        IO.puts("Error: #{reason}")
    end
  end

  # Function to highlight the text line by line.
  defp highlight_text(text) do
    text
    |> String.split("\n")
    |> Enum.map(&highlight_line/1)
    |> Enum.join("\n")
  end

  # Function to highlight a single line of code.
  defp highlight_line(line) do
    # String "" and ''
    line = highlight_regex(~r/("[^"\\]*(?:\\.[^"\\]*)*")/, line, "<span class=\"string\">\\1</span>")
    line = highlight_regex(~r/('[^'\\]*(?:\\.[^'\\]*)*')/, line, "<span class=\"string\">\\1</span>")

    # Numbers
    line = Regex.replace(~r/(\d+)/, line, "<span class=\"number\">\\1</span>")

    # Keywords
    line = highlight_regex(~r/\b(def|if|else|elif|for|while|in|return|try|import|break|except)\b/, line, "<span class=\"keyword\">\\1</span>")

    # Operators
    line = highlight_regex(~r/(\+|-|\*)/, line, "<span class=\"operator\">\\1</span>")
    #line = highlight_regex(~r/(=)/, line, "<span class=\"pink-operator\">\\1</span>")

    # Boolean
    line = highlight_regex(~r/\b(True|False)\b/, line, "<span class=\"boolean\">\\1</span>")

    # Functions
    line = highlight_regex(~r/\b(\w+)\(/, line, "<span class=\"function\">\\1</span>(")

    # Parenthesis
    line = highlight_regex(~r/(\(|\))/, line, "<span class=\"parenthesis\">\\1</span>")

    # Keys
    line = highlight_regex(~r/(\{|\})/, line, "<span class=\"keys\">\\1</span>")

    # Brackets
    line = highlight_regex(~r/(\[|\])/, line, "<span class=\"parenthesis\">\\1</span>")

    # Methods
    line = highlight_regex(~r/\.(?!\d)\w+/, line, ".<span class=\"method\">\\0</span>")

    # @...
    line = highlight_regex(~r/@(\w+)/, line, "@<span class=\"decorator\">\\1</span>")

    # Comments
    line = highlight_regex(~r/#(.*)$/, line, "<span class=\"comment\">#\\1</span>")
    if String.contains?(line, "#") do
      line = "<span class=\"comment\">#{line}</span>"
    end
    line = Regex.replace(~r/(<span class="comment">[^<]+)<span class="number">(\d+)<\/span>/, line, "\\1\\2")


    # Logical operators
    line = highlight_regex(~r/\b(and|or|not|\/)\b/, line, "<span class=\"logicaloperator\">\\1</span>")

    # Variables
    #line = highlight_regex(~r/\b([A-Za-z_ñÑ]|[A-Za-z_ñÑ\d]*)\b/, line, "<span class=\"variable\">\\1</span>")

    line
  end

  # Function to apply regex-based highlighting to a line of code.
  defp highlight_regex(regex, line, replacement) do
    Regex.replace(regex, line, replacement, global: true)
  end

  # Function to build the HTML content with highlighted text.
  defp build_html_content(highlighted_text) do
    """
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <link href="/syntax.css" type="text/css" rel="stylesheet">
      <title>Syntax Highlighter</title>
      <style>

      </style>
    </head>
    <body>
      <pre>
        #{highlighted_text}
      </pre>
    </body>
    </html>
    """
  end
end

# Usage:
Syntaxhighlighter.highlight("example.py")
