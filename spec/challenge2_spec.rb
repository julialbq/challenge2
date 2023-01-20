require_relative '../challenge2'
require 'spec_helper'

RSpec.describe Games do 
  describe '#match_report' do
    subject(:games){described_class.new('example.log')}

    it 'returns a game report by match' do
      game_report = subject.match_report

      expect(game_report).to be_an(Array)
    end

    it 'validates game report fields' do
      expected_game_report = {
        "game_0": {
          total_kills: 4,
          players: ["Isgalamido", "Mocinha", "Zeh", "Dono da Bola"],
          kills: {
            " Isgalamido"=> 1
          }
        }
      }
      game_report = subject.match_report

      expect(game_report[0]).to eq(expected_game_report)

    end
  end
end

# describe "should return a game report as a hash"
#     it "should create correspondent game hash" do
#         game = Games.new('example.log')
#         read = game.gameline_matches
#         expect(read).to match([{"killer"=>" Isgalamido", "killed"=>"Mocinha"}
#         {"killer"=>" <world>", "killed"=>"Zeh"}
#         {"killer"=>" <world>", "killed"=>"Zeh"}
#         {"killer"=>" <world>", "killed"=>"Dono da Bola"}])
#     end

#     it "should extract values according to the key supplied" do
#         game = Games.new('example.log')
#         read = game.hash_values([{"killer"=>" Isgalamido", "killed"=>"Mocinha"}
#         {"killer"=>" <world>", "killed"=>"Zeh"}
#         {"killer"=>" <world>", "killed"=>"Zeh"}
#         {"killer"=>" <world>", "killed"=>"Dono da Bola"}], 'killer')
#         expect(read). to match([" Isgalamido", " <world>", " <world>", " <world>"])
#     end
# end
