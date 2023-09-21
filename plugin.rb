# name: everviz-discourse-onebox
# about: everviz oneboxes
# version: 0.1
# authors: everviz, Martin Kleiven
# url: https://github.com/visual-elements/everviz-discourse-onebox

# frozen_string_literal: true

require "onebox"

# Discourse dies without this
Onebox = Onebox

module Onebox
    module Engine
        class EvervizOnebox
            include Engine
            include Engine::StandardEmbed
  
        r = %r{https?://app.everviz.com/embed/(?<uuid>.+)}
        always_https
        matches_regexp(r)
        
        def to_html
            o = get_oembed
            match = @url.match(%r{https?://app.everviz.com/(?:embed|share)/(?<uuid>.+)})

            # The image is a hack to make sure thumbnails are loaded
            <<~HTML
            <div class="everviz-box"> 
                <img
                    style="display: none;"
                    src="#{o.thumbnail_url}"
                    height="#{o.thumnail_height}"
                    width="#{o.thumnail_width}"
                />
                #{o.html}
            </div>
            HTML
          end
        end
      end
    end