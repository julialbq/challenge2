require_relative '../src/games'
require 'spec_helper'

RSpec.describe Games do 
  describe '#match_report' do
    subject(:games){described_class.new('spec/fixtures/example.log')}

    it 'returns a game report by match' do
      game_report = subject.match_report

      expect(game_report).to be_an(Array)
    end

    it 'validates game report fields' do
      expected_game_report = {
        "game_1": {
          total_kills: 4,
          players: ["Isgalamido", "Mocinha", "Zeh", "Dono da Bola"],
          kills: {
            " Isgalamido"=>1,
            "Dono da Bola"=>-1,
            "Zeh"=>-2
          }
        }
      }
      game_report = subject.match_report

      expect(game_report[1]).to eq(expected_game_report)
    end
  end

  describe '#game_report' do
    subject(:games){described_class.new('spec/fixtures/example.log')}

    it 'returns a hash' do
      game_report = subject.game_report

      expect(game_report).to be_an(Hash)
    end

    it 'returns expected game report' do
      expected_final_report = {
        game: 
        [{
          game_0: {
            total_kills: 0, 
            players: [], 
            kills: {}}
        }, 
        {
          game_1: {
            total_kills: 4, 
            players: ["Isgalamido", "Mocinha", "Zeh", "Dono da Bola"], 
            kills: {" Isgalamido"=>1, "Dono da Bola"=>-1, "Zeh"=>-2}}
        }], 
          ranking: {" Isgalamido"=>1, "Dono da Bola"=>-1, "Zeh"=>-2}
      }

      game_report = subject.game_report

      expect(game_report).to eq(expected_final_report)
    end
  end

  describe '#death_report' do
    subject(:games){described_class.new('spec/fixtures/example.log')}

    it 'returns an array' do
      game_report = subject.death_report

      expect(game_report).to be_an(Array)
    end

    it 'returns expected death report' do
      expected_death_report = [
        { game_0: {deaths: {}}}, 
        { game_1: {deaths: {
          [" MOD_TRIGGER_HURT"] => 2, 
          [" MOD_FALLING"] => 1, 
          [" MOD_ROCKET"] => 1}}
        }
      ]

      death_report = subject.death_report

      expect(death_report).to eq(expected_death_report)
    end
  end
end
