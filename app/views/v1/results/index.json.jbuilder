json.array! @questions do |question|
  json.partial! 'v1/questions/question', question: question

  json.results question.results do |result|
    json.partial! 'v1/results/result', result: result
  end
end
