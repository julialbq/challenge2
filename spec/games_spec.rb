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
      puts game_report

      expect(game_report[1]).to eq(expected_game_report)

    end
  end 
end
