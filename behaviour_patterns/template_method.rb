# frozen_string_literal: true

module StarWars
  class CloneAI
    def educate
      training
      arm
      attack
    end

    def training; end

    def arm; end

    def attack; end
  end

  class ClonePilotAI < CloneAI
    def training
      puts 'Пилотирование транспортных средств'
    end

    def arm
      puts 'Бластерный пистолет'
    end

    def attack
      puts 'Стрельба из бластерного пистолета'
    end
  end

  class EliteARFCloneAI < CloneAI
    def arm
      puts 'Легкая броня'
    end

    def training
      puts 'Скрытность'
    end

    def attack
      puts 'Стрельба из штурмовой винтовки'
    end
  end
end

pilot_ai = StarWars::ClonePilotAI.new
pilot_ai.educate

puts '-----------'

elite_ai = StarWars::EliteARFCloneAI.new
elite_ai.educate
