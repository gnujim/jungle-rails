class UserMailer < ApplicationMailer
  default from: 'no_reply@jungle.com'

  def order_receipt(order)
    @order = order
    @line_items = order.line_items
    
    mail(to: @order.email, 
        subject: "Your Receipt for Order No. #{@order.id}")
    
  end
end
