require 'date'

class CalendarDisplayer
  def initialize(year, month)
    @year = year
    @month = month
    @events = Hash.new { |h, k| h[k] = [] }
  end

  def add_event(day, event)
    # Ajoute l'événement tronqué à 9 caractères maximum
    @events[day] << event[0, 9]
  end

  def display
    # Détermine le premier jour du mois et le nombre de jours dans le mois
    first_day = Date.new(@year, @month)
    days_in_month = Date.new(@year, @month, -1).day
    start_wday = first_day.wday  # Jour de la semaine du premier jour du mois

    # En-tête avec les jours de la semaine
    header = (1..7).map { |d| d.to_s.ljust(9) }.join("|")
    puts "|#{header}|"

    # Affiche le calendrier semaine par semaine
    (1..days_in_month).each_slice(7) do |week|
      # Affiche les jours de la semaine
      week.each { |day| print "#{day.to_s.ljust(9)}|" }
      # Ajoute des espaces vides pour les semaines incomplètes
      (7-week.size).times { print "         |" }
      puts "\n" + ("|         |" * 3).rstrip  # Lignes vides pour les événements
      # Affiche jusqu'à trois lignes d'événements pour chaque jour
      (1..3).each do |_|
        week.each do |day|
          event = @events[day].shift  # Récupère et supprime l'événement pour ce jour
          # Affiche l'événement ou un espace vide
          print event ? "|#{event.ljust(9)}" : "|         "
        end
        # Ajoute des espaces vides pour les semaines incomplètes
        (7-week.size).times { print "|         " }
        puts "|"  # Fin de la ligne
      end
    end
  end
end

# Exemple d'utilisation
calendar = CalendarDisplayer.new(2024, 5)
calendar.add_event(3, "9:00AM Sandbox")
calendar.add_event(3, "11:00AM Review")
calendar.add_event(10, "Submission")
calendar.add_event(31, "7:30PM Party")

calendar.display
