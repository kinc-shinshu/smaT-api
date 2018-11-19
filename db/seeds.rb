# create teacher as Administrator
# 'teacher'
t = Teacher.create!(fullname: 'Smart Teacher', username: 'smat', password_digest: '50ecc45020be014e68d714cd076007e84a9621d9a5e589a916e45273014830b399d143a57f525554bfe9e751d97fe0fa884dbdea7b07721723b4eff39e9d28ad')

# create exams
10.times do |i|
  t.exams.create!(title: "Exam#{i}")
end

# create questions
q_smatex = ['#{4}', '[3]%[6]', '3*4', '25/5', '55^2']
q_latex  = ['\\sqrt{4}', '\\frac{3}{6}', '3 \\times 4', '25 \\div 5', '55^2']
a_smatex = ['+-2', '[1]%[2]', '12', '5', '3025']
a_latex  = ['+-2', '\\frac{1}{2}', '12', '5', '3025']

t.exams.each do |exam|
  5.times do
    q_idx = rand(0..4)
    exam.questions.create!(
      smatex: q_smatex[q_idx],
      latex: q_latex[q_idx],
      ans_smatex: a_smatex[q_idx],
      ans_latex: a_latex[q_idx],
      question_type: 'Math'
    )
  end
end
