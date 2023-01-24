class Games
    attr_reader :log
  
    def initialize(log)
      @log = log
    end
  
    
    def match_report
      game =  match_lines(/:(?<killer>[^:]+) killed (?<killed>.+) by/)
      game.map do |match|
        {
          "game_#{game.index(match)}": {
            total_kills: separate_values(match, 'killed').flatten.size,
            players: players(match),
            kills: kills_by_player(match),
          }
        }
      end
    end

    def game_report
      game = match_lines(/:(?<killer>[^:]+) killed (?<killed>.+) by/).flatten
      
      {
      game: match_report,
      ranking: kills_by_player(game)
      }
    end

    def death_report
      game = match_lines(/(?<death> MOD_.+)/).to_a
      game.map do |match|
        {
          "game_#{game.index(match)}": {
              deaths: count_deaths(match)
          }
        }
      end
    end

    private

    def read_file
      File.foreach(log).select do | line | 
        line.include?("InitGame") || line.include?("killed")
      end.slice_after(/InitGame/)
    end
  
    def match_lines(regex)
      game = read_file.map do |gamelines|
        gamelines.map do |gameline|
          match = gameline.match(regex)
          match ? match.named_captures : nil
        end.compact
     
      end
      game
    end
    
    def count_deaths(match)
      match_count = match.group_by(&:itself).to_h do |death, means_of_death| 
        [death.values, means_of_death.count]
      end
      match_count.sort_by{ |key, value| value }.reverse.to_h
    end
  
    def separate_values(match, given_key)
      results = match.flat_map do |gamer|
        gamer.values_at(given_key)
      end
  
      results
    end

    def players(match)
      killers = separate_values(match, 'killer').uniq
      killed = separate_values(match, 'killed').uniq
      killers_modified = killers.map{ |killer| killer.strip}
  
      players = killers_modified.concat(killed)
      filtered_players = players.uniq
      filtered_players.delete("<world>")
      
      filtered_players
    end
  
    def kills_by_player(match)
      killer_score = Hash.new
     
      match.select  do |kills|    
        killer = kills['killer']
        killed = kills['killed']

        if killer == killed or killer == ' <world>'
          if killer_score.has_key?(killed)
            killer_score[killed] -= 1
          else
            killer_score[killed] = -1
          end
        else 
          if killer_score.has_key?(killer)
            killer_score[killer] += 1
          else
            killer_score[killer] = 1
          end
        end
      end
      
      killer_score.delete(" <world>")
      killer_score.sort_by{ |key, value| value }.reverse.to_h
    end
  
  end
