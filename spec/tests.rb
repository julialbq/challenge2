require '../challenge2'

describe "should return a game report as a hash"
    it "should create correspondent game hash" do
        game = Games.new('example.log')
        read = game.gameline_matches
        expect(read).to match([{"killer"=>" Isgalamido", "killed"=>"Mocinha"}
        {"killer"=>" <world>", "killed"=>"Zeh"}
        {"killer"=>" <world>", "killed"=>"Zeh"}
        {"killer"=>" <world>", "killed"=>"Dono da Bola"}])
    end

    it "should extract values according to the key supplied" do
        game = Games.new('example.log')
        read = game.hash_values([{"killer"=>" Isgalamido", "killed"=>"Mocinha"}
        {"killer"=>" <world>", "killed"=>"Zeh"}
        {"killer"=>" <world>", "killed"=>"Zeh"}
        {"killer"=>" <world>", "killed"=>"Dono da Bola"}], 'killer')
        expect(read). to match([" Isgalamido", " <world>", " <world>", " <world>"])
    end
end
