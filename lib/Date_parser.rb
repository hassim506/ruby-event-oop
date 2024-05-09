require 'date'

class DateParser
  # Définition des correspondances mois - numéro pour initialiser le calendrierrrrrrrrrrrr
  MONTHS = {
    "janvier" => 1, "février" => 2, "mars" => 3, "avril" => 4,
    "mai" => 5, "juin" => 6, "juillet" => 7, "août" => 8,
    "septembre" => 9, "octobre" => 10, "novembre" => 11, "décembre" => 12
  }

  # Parse la chaîne de caractères pour trouver une date et une heure correzpondanteeeeeee
  def self.parse(text)
    date = DateTime.now  # Date de départ pour le calcul initialllllllllllll
    if match = text.match(/le (\d{1,2}) (\w+) à (\d{1,2}) h(?: (\d{1,2}))?/)
      day, month, hour, minute = match.captures
      month = MONTHS[month.downcase]
      date = DateTime.new(date.year, month, day.to_i, hour.to_i, (minute || "0").to_i)
    elsif match = text.match(/(\w+) prochain à (\d{1,2}) h(?: (\d{1,2}))?/)
      day_name, hour, minute = match.captures
      days_ahead = (DAYS[day_name.downcase] - date.wday) % 7
      days_ahead += 7 if days_ahead == 0
      date += days_ahead
      date = DateTime.new(date.year, date.month, date.day, hour.to_i, (minute || "0").to_i)
    end
    date
  end
end

# Exemples d'utilisation
puts DateParser.parse("le 14 octobre à 15 h")
puts DateParser.parse("mardi prochain à 14 h")
