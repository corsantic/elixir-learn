ExUnit.start()

defmodule HighScoreTest do
  use ExUnit.Case

  @default_map %{"Dave" => 10}

  test "new empty map" do
    assert HighScore.new() == %{}
  end

  test "add_player add player to map" do
    score_map = HighScore.new()
    score_map = HighScore.add_player(score_map, "Dave")
    assert score_map == %{"Dave" => 0}

    assert HighScore.add_player(score_map, "Chuck", 10) == %{"Dave" => 0, "Chuck" => 10}
  end

  test "add_player add player to map with score" do
    assert HighScore.add_player(%{}, "Dave", 10) == @default_map
  end

  test "remove_player remove player to map" do
    assert HighScore.remove_player(@default_map, "Dave") == %{}
  end

  test "reset_score/2 resetting score for non existent player sets player score to 0" do
    scores = HighScore.new() |> HighScore.reset_score("José Valim")
    assert scores == %{"José Valim" => 0}
  end

  test "reset_score reset player score to zero" do
    assert HighScore.reset_score(@default_map, "Dave") == %{"Dave" => 0}
  end

  test "update_score add given value to existing value of the key" do
    assert HighScore.update_score(@default_map, "Dave", 5) == %{"Dave" => 15}
  end

  test "test update_score/3 update score for non existent player initializes value" do
    scores = HighScore.new() |> HighScore.update_score("José Valim", 486_373)
    assert scores == %{"José Valim" => 486_373}
  end

  test "get_players get keys of the map" do
    score_map = %{"Dave" => 0, "Chuck" => 10}
    assert HighScore.get_players(score_map) == ["Dave", "Chuck"] or ["Chuck", "Dave"]
  end
end
