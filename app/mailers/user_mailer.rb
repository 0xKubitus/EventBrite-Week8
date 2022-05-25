class UserMailer < ApplicationMailer
  default from: 'julien.tamil@gmail.com'
 
  def welcome_email(user)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = user 

    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'https://eventbrite-ja.herokuapp.com/users/sign_in' 

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: 'Bienvenue chez nous !') 
  end

  def new_attendee_email(admin, attendance)
    #on récupère l'instance admin et attendance pour ensuite pouvoir les passer à la view en @admin et @attendance
    @admin = admin 
    @attendance = attendance
    
    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'https://eventbrite-ja.herokuapp.com/users/sign_in' 

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @admin.email, subject: 'Un nouveau participant s\'est inscrit à votre évènement !') 
  end
end