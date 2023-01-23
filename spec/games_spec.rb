require_relative '../src/games'
require 'spec_helper'

RSpec.describe Games do 
  describe '#match_report' do
    subject(:games){described_class.new('spec/fixtures/example.log')}

    it 'returns an Array' do
      game_report = subject.match_report

      expect(game_report).to be_an(Array)
    end

    it 'returns expected game report' do
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

    it 'returns a game report by match and ranking by kills' do
      game_report = subject.game_report

      expect(game_report).to be_an(Hash)
    end

    it 'validates game report and ranking by kills fields' do
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
end
