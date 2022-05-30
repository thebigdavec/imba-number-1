tag answers-list
	css	.answers
		d:flex
		flex-wrap:wrap
		row-gap:.05rem
		column-gap:.5rem
	css	.answer
		p:.5em 1em
		bd:4px solid white
		bgc:cooler2
		border-radius:xl
		@hover bgc:cooler3
	css .selected-answer
		font-style:italic
		bgc:lilac1
		box-shadow: 0 0 4px 0 lilac6 inset
	css .correct-answer
		bgc:green1
		box-shadow: 0 0 4px 0 green6 inset
		font-weight:bold
	css .selected-answer.correct-answer
		bgc:green3
		box-shadow: 0 0 4px 0 green6 inset
		bd:4px solid green3

	prop answers
	prop id
	prop showResults
	prop selectAnswer

	<self>
		<div.answers>
			for answer in answers
				<button
					.answer
					.selected-answer=answer.isSelected
					.correct-answer=(answer.isCorrect and showResults)
					@click=emit("selectAnswer", {text: answer.text, id})
				>
					answer.text
