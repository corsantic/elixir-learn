defmodule Newsletter do
  def read_emails(path) do
    File.read!(path) |> String.trim() |> String.split("\n") |> Enum.filter(&(&1 != ""))
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    IO.puts(pid, email)
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    emails = read_emails(emails_path)
    file_pid = open_log(log_path)

    Enum.each(emails, fn email ->
      result = send_fun.(email)

      if(result == :ok) do
        log_sent_email(file_pid, email)
      end
    end)

    close_log(file_pid)
  end
end
