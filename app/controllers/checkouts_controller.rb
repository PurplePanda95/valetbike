class CheckoutsController < ApplicationController
    def create
        cancel_url = pages_home_url
        success_url = pages_home_url
        metadata = {}
        amount = 700
        name = "Test"
        if params[:type] == "0"
            @membershipassignment = MembershipAssignment.new(user_id: current_user.id, membership_id: params[:id])
            @membershipassignment.start = Time.now
            unless @membershipassignment.save 
                redirect_to add_membership_path and return
                #render('membership_assignment/new') and return
            end
            if @membershipassignment.membership.cost == 0
                redirect_to account_path and return
            end
            cancel_url = add_membership_url
            success_url = account_url
            #success_url = membership_assignment_create_url(:membership_assignment=>{:user_id=>current_user.id, :membership_id=>params[:id]})
            puts success_url
            #success_url = {:controller => "membership_assignment", :action => "create", :membershipassignment=>{:user_id=>current_user.id, :membership_id=>params[:id]}}
            metadata = {membership_assignment_id: @membershipassignment.id}
            amount = @membershipassignment.membership.price_in_cents
            puts "amount: " + amount.to_s 
            name = @membershipassignment.membership.name
        elsif params[:type] == "1"
            cancel_url = stations_index_url
            metadata = {rental_id: params[:id]}
            amount = 2000
            name = "30 minute bike rental"
        elsif params[:type] == "2"
            cancel_url = account_url
            success_url = remove_overdue_url(overdue_paid: 1)
            metadata = {overdue_id: params[:id]}
            amount = Overdue.find(params[:id]).cost
            if amount == 0
                Overdue.destroy(params[:id])
                redirect_to success_url
                return
            end
            #Overdue.destroy(params[:id])
            name = "Overtime charge"
        end
        if amount < 50
          amount = 50
        end
        @session = Stripe::Checkout::Session.create({
          success_url: success_url,
          cancel_url: cancel_url,
          payment_method_types: ['card'],
          line_items: [{
            price_data: {
                currency: 'usd',
                unit_amount: amount,
                product_data: {
                  name: name,
                },
              },
              quantity: 1
          }],
          mode: 'payment',
          metadata: metadata
          #customer_email: current_user.email        
        })
        #puts @session
        # render 'checkouts/pay'
        redirect_to checkouts_pay_path(:id => @session.id)
        #render  @session.url, allow_other_host: true
        # respond_to do |format|
        #   format.js
        # end
        # redirect_to Stripe::Checkout::Session.retrieve(@session.id).url, allow_other_host: true
      end      
      def pay
        @session = Stripe::Checkout::Session.retrieve(params[:id])
      end
end
