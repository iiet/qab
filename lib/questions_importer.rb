class QuestionsImporter
  # heavily based on https://github.com/gronostajo/drill2
  def from_string(data)
    matched_questions = data.split /(?:\r?\n){2,}/
    errors = []
    options = nil

    if matched_options = matched_questions.last.match(/<options>\s*(\{(?:.|\n|\r)*})\s*/)
      begin
        options = JSON.parse(matched_options[1])
      rescue => e
        errors << e.message
      end
    end

    questions = matched_questions.map do |q|
      parse_question q
    end.compact

    if options && explanations = options.delete('explanations')
      explanations.each do |k,e|
        if q = questions.detect{|q| q[:number] == k}
          q[:explanation] = e
        end
      end
    end
    { questions: questions, options: options, errors: errors }
  end

  def parse_question(data)
    lines = data.split /(?:\r?\n)/

    body = []

    question = {
      question: nil,
      answers: [],
      number: nil,
      explanation: nil
    }

    lines.each do |l|
      matched_answer = l.match /^\s*(>+)?\s*([A-Z])\)\s*(.+)$/i
      
      if !matched_answer && question[:answers].empty?
        if body.empty?
          if matched_question_with_number = l.match(/^\[#([a-zA-Z\d\-+_]+)\]\s*(.+)$/)
            question[:number] = matched_question_with_number[1]
            l = matched_question_with_number[2]
          end
        end
        body << l
      elsif !matched_answer && !question[:answers].empty?
        question[:answers].last[:answer] += l
      else
        if !question[:question]
          question[:question] = body.join("\n")
        end

        question[:answers] << {
          answer: matched_answer[3],
          correct: !matched_answer[1].present?,
          letter: matched_answer[2].upcase
        }
      end
    end
    if question[:answers].count >= 2 and question[:answers].select{|a| a[:correct]}.count >= 1
      question
    else 
      nil
    end
  end
end