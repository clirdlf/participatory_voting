# frozen_string_literal: true

##
# Helpers for Proposal
module ProposalsHelper
  ##
  # Display formatted likes
  #
  # @param proposal Proposal to display likes for
  # @return Formatted HTML (heart icon with number of votes)
  def display_likes(proposal)
    '<span class="fas fa-heart red"></span> '.html_safe + \
      pluralize(proposal.cached_votes_score, 'Like')
  end

  ##
  # Wrapper for displaying statistics about the voting
  #
  # @param title Title to use on the card
  # @param text Text to use on the card
  # @return String formatted HTML Boostrap card
  def stats_card(title, text)
    "<div class='card'>
      <div class='card-body'>
        <h5 class='card-title'>
          #{title}
        </h5>
        <p class='card-text'>#{text}</p>
      </div>
    </div>".html_safe
  end

  ##
  # Map icons to the formats
  #
  # @param format Format from data
  # @return String HTML string of FontAwesome icon
  def format_icon(format)
    icon = case format
           when 'NDSA Working Group Meeting'
             'users'
           when '15-minute Presentation'
             'user'
           when 'Dork Shorts'
             'hand-spock'
           when 'Snapshot'
             'camera'
           when 'Panel'
             'users'
           when '15-minute Talk/Demo'
             'desktop'
           when '10-15-minute Tutorial'
             'handshake-angle'
           when 'Workshop'
             'handshake-angle'
           when 'Hands-on Workshop'
             'handshake-angle'
           when '45-minute Workshop'
             'handshake-angle'
            when '90-minute Workshop'
              'handshake-angle'
           when '3 Hour Workshop'
             'handshake-angle'
           when 'Poster'
             'map'
           # icon = 'hand-spock-o'
           when '5-minute Lightning Talk'
             'bolt'
           when '25-minute Birds of a Feather (BOAF) Session'
             'feather'
           when 'Solution Room'
             'house-user'
           when '6:2:1 Lightning Talk'
             # icon = 'lightbulb-o'
             'bolt'
           when 'Lunchtime Working Session'
             'flask'
           else
             'user'
           end

    "<span class='fa-solid fa-#{icon}' aria-hidden='true'></span>".html_safe
  end
end
