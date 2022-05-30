import { nanoid } from 'nanoid'
import { decode } from 'html-entities'

export default def getQuestions
	const GENERALKNOWLEDGE =
		'https://opentdb.com/api.php?amount=5&category=9&type=multiple'

	let questions

	try
		const response = await window.fetch(GENERALKNOWLEDGE)
		const data = await response.json()
		const quizData = data.results

		questions = quizData.map do(question, index)
			const id = nanoid()
			const data = {
				id,
				question: decode(question.question),
				answers:[
					{
						text: decode(question.correct_answer),
						isCorrect: true,
						isSelected: false
					},
					...question.incorrect_answers.map do(answer)
						{
							text: decode(answer),
							isCorrect: false,
							isSelected: false
						}
				].sort do() Math.random() - 0.5
			}
			# data.answers = sortOfRandom(data.answers)
			return data

		return questions
	catch e
		console.error "It failed", e.message
