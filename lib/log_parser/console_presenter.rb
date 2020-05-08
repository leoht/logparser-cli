# frozen_string_literal: true
module LogParser
  class ConsolePresenter
    def render(pageviews)
      [
        "\n######### Total pageviews #########\n\n",
        render_pageviews(pageviews.total_pageviews),
        "\n",
        "######### Unique pageviews ########\n\n",
        render_pageviews(pageviews.unique_pageviews),
      ].flatten.join
    end

    private

    def render_pageviews(pageviews_hash)
      pageviews_hash.map do |path, count|
        render_path_and_count(path, count)
      end
    end

    def render_path_and_count(path, count)
      "#{count}\t\t#{path}\n"
    end
  end
end
