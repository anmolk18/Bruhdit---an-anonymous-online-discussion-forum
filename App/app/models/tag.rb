class Tag < ApplicationRecord
    has_many :post_tags
    has_many :posts, through: :post_tags

    validates :name, presence: true

    def self.tag_count_hash
        tags = {}
        Tag.all.each do |tag|
            tags[tag] = tag.posts.count
        end
        tags
    end

    def self.ordered_by_count
        tags = self.tag_count_hash
        Hash[tags.sort_by{|k, v| v}.reverse]
    end

    def self.top_ten_tags
        tags = self.ordered_by_count
        tags.first(10).to_h
    end

    def self.most_popular
        tags = self.ordered_by_count
        tags.first
    end

    def self.least_popular
        tags = self.ordered_by_count
        tags.reverse_each.first
    end

    def self.tag_colors
        colors = ['d5', 'd4', 'd3', 'd2', 'd1', 'l1', 'l2', 'l3', 'l4', 'l5']

        tags = self.top_ten_tags

        i = 0
        tags.each do |tag, value|
            tags[tag] = "w3-tag w3-small w3-theme-" + colors[i].to_s
            i += 1
        end
        tags
    end

    def self.ordered_by_creation
        Tag.all.reverse
    end

    def self.newest_ten_tags
        tags = self.ordered_by_creation
        tags.first(10)
    end

    def self.newest_tag
        tags = self.ordered_by_creation
        tags.first
    end
end