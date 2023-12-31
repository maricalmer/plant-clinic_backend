module Types
  class QueryType < BaseObject
    add_field GraphQL::Types::Relay::NodeField
    add_field GraphQL::Types::Relay::NodesField

    field :fetch_post, resolver: Queries::FetchPost
    field :all_posts, resolver: Resolvers::PostsSearch
    field :_all_posts_meta, QueryMetaType, null: false

    def _all_posts_meta
      Post.count
    end
  end
end
