# frozen_string_literal: true

##
# Page controller
class PagesController < ApplicationController
  def home; end

  def stats
    @proposals = Proposal.all.order(:title)
  end
end
