puts 'User: Create admin'
User.create(email: 'administrator@appprova.com.br', password: 'change123', password_confirmation: 'change123', admin: true)
