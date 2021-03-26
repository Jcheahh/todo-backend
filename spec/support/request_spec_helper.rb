module RequestSpecHelper
    def json
        p response.body
        JSON.parse(response.body)
    end
end