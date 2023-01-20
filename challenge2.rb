class Games
    attr_reader :log
  
    def initialize(log)
      @log = log
    end
  
    
    def match_report
      game = gameline_matches()
      game.map do |match|
        {
          "game_#{game.index(match)}": {
            total_kills: total_kill(match, 'killed'),
            players: get_players(match, 'killer', 'killed'),
            kills: kills_by_player(match),
          }
        }
      end
    end

    def game_report
      game = gameline_matches.flatten
      
      "{
      #{match_report}  
      },
      {
      #{kills_by_player(game)}
      }"
    end

    private

    def readFile
      file = File.foreach(log).slice_after(/InitGame/)
    end
  
    def gameline_matches
      game = readFile.map do |gamelines|
        gamelines.map do |gameline|
          match = gameline.match(/:(?<killer>[^:]+) killed (?<killed>.+) by/)
          match ? match.named_captures : nil
        end.compact
     
      end
      game.delete([])
      game
    end
  
    def hash_values(match, given_key)
  
      results = match.flat_map do |gamer|
        gamer.values_at(given_key)
      end
  
      results
    end
  
    def remove_duplicates(match, given_key)
  
      killers_array = hash_values(match, given_key) 
      total_killers= killers_array.uniq
      total_killers
    end
    def total_kill(match, given_key)
  
      killed_array = hash_values(match, given_key) 
      killed_array.flatten.size
    end

    def get_players(match, given_key1, given_key2)

      killers = remove_duplicates(match, given_key1)
      killed = remove_duplicates(match, given_key2)
      killers_modified = killers.map{ |killer| killer.strip}
  
      players = killers_modified.concat(killed)
      filtered_players = players.uniq
      filtered_players.delete("<world>")
      
      filtered_players

    end
  
    def kills_by_player(match)
      killer_score = Hash.new
     
      match.select  do |kills|    
        if kills['killer'] == kills['killed'] or kills['killer'] == ' <world>'
          if killer_score.has_key?(kills['killer'])
            killer_score[kills['killer']] -= 1
          else
            killer_score[kills['killer']] = 0
            killer_score[kills['killer']] -= 1
          end
        else 
          if killer_score.has_key?(kills['killer'])
            killer_score[kills['killer']] += 1
          else
            killer_score[kills['killer']] = 0
            killer_score[kills['killer']] += 1
          end
        end
      end
      killer_score.delete(" <world>")
      killer_score
    end
  
  end
  
  game = Games.new('games.log')
  puts game.game_report
  
