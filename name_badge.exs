defmodule NameBadge do
  def print(id, name, department) do
    id_text = if id, do: "[#{id}] - ", else: ""
    name_text = "#{name} - "
    department_text = if(department, do: department |> String.upcase(), else: "OWNER")
    "#{id_text}#{name_text}#{department_text}"
  end
end

ExUnit.start()

defmodule NameBadgeTest do
  use ExUnit.Case

  test "print check Upper Case" do
    assert NameBadge.print(67, "Katherine Williams", "Strategic Communication") ==
             "[67] - Katherine Williams - STRATEGIC COMMUNICATION"
  end

  test "print check nil id" do
    assert NameBadge.print(nil, "Katherine Williams", "Strategic Communication") ==
             "Katherine Williams - STRATEGIC COMMUNICATION"
  end

  test "print check nil department return OWNER" do
    assert NameBadge.print(nil, "Rachel Miller", nil) == "Rachel Miller - OWNER"
  end
end
