defmodule SimpleCardBrandCliTest do
  @moduledoc """
  Test the CLI.
  """

  use ExUnit.Case
  import ExUnit.CaptureIO

  test "Valid CLI Visa PAN." do
    assert capture_io(fn -> Commandline.CLI.main(["4111111111111111"]) end) ==
             "PAN: 4111111111111111 -> Brand: visa\n"
  end

  test "Valid CLI Mastercard PAN prefix and length." do
    assert capture_io(fn -> Commandline.CLI.main(["5123456", "--pan-length=16"]) end) ==
             "PAN: 5123456 -> Brand: mastercard\n"
  end

  test "Invalid PAN." do
    assert capture_io(fn -> Commandline.CLI.main(["411111111111111156784"]) end) ==
             "PAN: 411111111111111156784 -> Maximum PAN length is 19, found 21.\n"
  end

  test "Invalid PAN prefix and length." do
    assert capture_io(fn -> Commandline.CLI.main(["5123456", "--pan-length=12"]) end) ==
             "PAN: 5123456 -> Unknown card brand.\n"
  end
end
