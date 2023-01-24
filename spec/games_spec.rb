require_relative '../src/games'
require 'spec_helper'

RSpec.describe Games do 
  describe '#match_report' do
    subject(:match_report){ described_class.new('spec/fixtures/example.log').match_report }

    let(:expected_game_report) {{
      "game_1": {
        total_kills: 4,
        players: ["Isgalamido", "Mocinha", "Zeh", "Dono da Bola"],
        kills: {
          " Isgalamido"=>1,
          "Dono da Bola"=>-1,
          "Zeh"=>-2
        }
      }
    }}
    
    it 'returns a game report by match' do
      expect(match_report).to be_an(Array)
    end

    it 'validates game report fields' do

      expect(match_report[1]).to eq(expected_game_report)
    end
  end

  describe '#game_report' do
    subject(:game_report){ described_class.new('spec/fixtures/example.log').game_report }

    let(:expected_final_report) {{
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
    }}

    it 'returns a hash' do
      expect(game_report).to be_an(Hash)
    end

    it 'returns expected game report' do

      expect(game_report).to eq(expected_final_report)
    end
  end

  describe '#death_report' do
    subject(:death_report) { described_class.new('spec/fixtures/example.log').death_report }
    
    let(:expected_death_report) {[
      { game_0: {deaths: {}}}, 
      { game_1: {deaths: {
        [" MOD_TRIGGER_HURT"] => 2, 
        [" MOD_FALLING"] => 1, 
        [" MOD_ROCKET"] => 1}}
      }
    ]}

    it 'returns an array' do
      p death_report
      expect(death_report).to be_an(Array)
    end

    it 'returns expected death report' do

      expect(death_report).to eq(expected_death_report)
    end
  end
end
