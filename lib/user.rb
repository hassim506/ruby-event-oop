class User
  @@all_users = []  # Variable de classe pour stocker tous les utilisateurs

  attr_accessor :email, :age

  def initialize(email, age)
    @email = email
    @age = age
    @@all_users << self  # Ajoute chaque nouvel utilisateur au tableau de variables de classe
  end

  def self.all
    @@all_users
  end
end
