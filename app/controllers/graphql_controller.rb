class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately

  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      session: session,
      current_user: current_user
    }
    puts "CONTEXT FROM GRAPHQL CONTROLLER: #{context}"
    puts "SESSION FROM GRAPHQL CONTROLLER: #{session}"
    puts "SESSION_TOKEN FROM GRAPHQL CONTROLLER (execute): #{session[:token]}"
    result = PlantClinicSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?
    handle_error_in_development(e)
  end

  private

  def current_user
    puts "SESSION_TOKEN FROM GRAPHQL CONTROLLER (current_user): #{session[:token]}"
    return unless session[:token]

    AuthToken.user_from_token(session[:token])

  rescue ActiveSupport::MessageVerifier::InvalidSignature
    nil
  end

  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end
end
