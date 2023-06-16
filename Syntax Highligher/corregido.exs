defmodule Syntaxhighlighter do
  import Path

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

  defp highlight_text(text) do
    text
    |> String.split("\n")
    |> Enum.map(&highlight_line/1)
    |> Enum.join("\n")
  end

  defp highlight_line(line) do
    with [%{captures: match_string}] <- Regex.run(~r/("[^"\\](?:\\.[^"\\])*")/, line) do
      IO.inspect(match_string)
      variable = "<span class=\"string\">"
      add_list([], variable, match_string)
    else
      _ -> line
    end
  end

  defp add_list(list, variable, token) do
    variablelist = variable <> token <> "</span> <br>"
    [variablelist | list]
  end

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
        /* Add your CSS styling rules here */
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

Syntaxhighlighter.highlight("example.py")
