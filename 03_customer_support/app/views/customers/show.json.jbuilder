json.partial! 'user', user: @customer

json.support_requests @customer.support_requests.sort.reverse,
                      partial: 'support_requests',
                      as: :support_request