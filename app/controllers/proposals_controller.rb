class ProposalsController < ApplicationController

  def new
    @proposal = Proposal.new
  end

  def create
    @proposal = Proposal.new params[:proposal]

    if @proposal.save
      flash[:notice] = 'Thank you for your proposal.  Someone will contact you by August 15th.'
      redirect_to root_path
    else
      render :action => "new"
    end
  end

end
