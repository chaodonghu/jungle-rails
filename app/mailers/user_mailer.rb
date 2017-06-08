class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def orderconf_email(order)
    # byebug
     @order = order
     @user = @order.user
     @url = "http://0.0.0.0:3000/order/#{order.id}"
     mail(to: @user.email, subject: 'Your order #{order.id} has been confirmed')

   end
 end
