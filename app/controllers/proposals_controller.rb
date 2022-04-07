# frozen_string_literal: true

##
# Main controller for a Proposal
class ProposalsController < ApplicationController
  # before_action :set_proposal, only: %i[show edit update destroy like unlike]
  before_action :set_proposal, only: %i[like unlike]
  before_action :set_proposals, only: %i[index stats]
  before_action :authenticate_user!, only: %i[like unlike]

  # GET /proposals
  # GET /proposals.json
  def index; end

  def stats; end

  def like
    @proposal.liked_by current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def unlike
    @proposal.unliked_by current_user
    # render layout: false
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_proposal
    @proposal = Proposal.find(params[:id])
  end

  def set_proposals
    @proposals = Proposal.all
  end

  # Only allow a list of trusted parameters through.
  # def proposal_params
  #   params.require(:proposal).permit(:author, :title, :abstract)
  # end
end
