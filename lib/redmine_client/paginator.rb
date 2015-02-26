module RedmineClient
  module Paginator
    def get
      if @params[:page]
        if @params.delete(:paginate_with_kaminari) == true
          response = api.get(url, @params)
          pagination = JSON.parse(response.env.response_headers['X-Pagination'])
          Kaminari.paginate_array(convert_response(response), total_count: pagination['total_count']).page(pagination['page']).per(pagination['per_page'])
        else
          super
        end
      else
        Enumerator.new do |yielder|
          @params.merge!(page: 1)
          result = api.get(url, @params)
          pagination = JSON.parse(result.env.response_headers['X-Pagination'])
          current_page = pagination['page']
          total_pages  = (pagination['total_count'].to_f / pagination['per_page']).ceil

          loop do
            raise StopIteration if total_pages == 0

            # Yield the results we got in the body.
            result.body.each do |item|
              yielder << @klass.new(item)
            end

            # Only make a request to get the next page if we have not
            # reached the last page yet.
            raise StopIteration if current_page == total_pages
            @params.merge!(page: current_page + 1)
            result = api.get(url, @params)
            pagination = JSON.parse(result.env.response_headers['X-Pagination'])
            current_page = pagination['page']
          end
        end
      end
    end
  end
end
