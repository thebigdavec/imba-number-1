import confetti from 'canvas-confetti'
import './cover-page'
import './answers-list'
import getQuestions from './getQuestions'

global css html
	ff:sans
	button cursor:pointer
global css body
	m:0
	p:1rem 2rem
	d:grid
	min-height:100vh
	j:center
	button
		cursor:pointer
global css .btn
	p:.6rem 1rem
	bd:none
	bgc:lilac2
	text-transform:uppercase
	letter-spacing:1px
	fw:bold
	border-radius:0.5rem
	&:hover
		bgc:lilac3
	

const GENERALKNOWLEDGE = 'https://opentdb.com/api.php?amount=5&category=9&type=multiple'
let questions = []

tag app
	css .quiz
			d:vflex
			gap: 1.5rem
			max-width:750px
			margin-inline: auto
	css .question
			d:grid
			gap:.5rem
	css .question--text
			fw:bold
	css .end-actions
			d:flex
			mt:2rem
			gap:1rem
			ja:center
			span
				fw:bold
				fs:1.2em
				margin-inline:.25em

	prop gameStarted? = false
	prop loadingQuestions? = false
	prop showResults? = false
	prop score = 0

	def startGame
		loadingQuestions? = true
		gameStarted? = true
		questions = await getQuestions!
		loadingQuestions? = false
		showResults? = false

	def selectedAnswer e
		if showResults?
			return
		const question = questions.find do(question)
			question.id == e.detail.id

		for answer in question.answers
			answer.isSelected = answer.text === e.detail.text

	def allAnswered
		questions.every do(question)
			question.answers.some do(answer)
				answer.isSelected

	def checkAnswers
		score = 0
		for question in questions
			for answer in question.answers
				if answer.isSelected && answer.isCorrect
					score++
		showResults? = true
		if score === questions.length
			confetti!

	def render
		<self>
			<cover-page @go=startGame> unless gameStarted?
			if gameStarted?
				<div.quiz>
					if not questions..length
						<h1> "Loading questions..."
					else
						<h1[text-align:center]> "It's a quiz"
						for question in questions
							<div.question>
								<div.question--text> question.question
								<answers-list
									@selectAnswer=selectedAnswer(e)
									answers=question.answers
									id=question.id
									showResults=showResults?
								>
						if allAnswered! and not showResults?
							<div.end-actions>
								<button.btn @click=checkAnswers> "Check answers"
						if showResults?
							<div.end-actions>
								<div>
									"You scored"
									<span> score
									"out of"
									<span> questions.length
								<button.btn @click=startGame> "Play again"

imba.mount <app>
