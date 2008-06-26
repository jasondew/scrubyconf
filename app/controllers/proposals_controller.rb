class ProposalsController < ApplicationController

  before_filter :verify_human

  def new
    @proposal = Proposal.new
  end

  def create
    @proposal = Proposal.new params[:proposal]

    if @proposal.save
      flash[:notice] = 'Thank you for your proposal.  Someone will contact you by August 15th.'
      redirect_to root_path
    else
      flash[:notice] = @proposal.errors.full_messages.join('<br />')
      render :action => "new"
    end
  end

  private

  def verify_human
    redirect_to root_path unless params[:iamrobot].blank?
  end

end
