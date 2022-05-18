//
//  ContentView.swift
//  hand-on-hearts
//
//  Created by Alvin Tu on 5/18/22.
//

import SwiftUI

struct Course: Identifiable {
	let name: String
	let description: String
	let cost: Int
	let hours: Float
	let id = UUID()
}


struct ContentView: View {
	
	let courses : [Course] = [
		Course(name: "CPR & First Aid", description: "Learn to give CPR and first aid", cost: 100, hours: 4.5),
		Course(name: "Basic Life Support", description: "Learn basic life support", cost: 120, hours: 5.0)

	]
	
    var body: some View {
		
			List(courses) {
				CourseView(course: $0)
					
				
			}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
		
    }
}

struct CourseView: View {
	let course: Course
	@State private var showingCourse = false
	var body: some View {
		VStack {
		Text(course.name)
		Text(course.description)
		HStack {
		Text("$" + String(course.cost))
		Text("number of hours : " + String(course.hours))
		}
		}
		.onTapGesture {
			showingCourse.toggle()
		}
		.sheet(isPresented: $showingCourse) {
			DetailedCourseView(course: course)
		}

	}
}


struct DetailedCourseView: View {
	let course: Course
	@Environment(\.dismiss) var dismiss
	@State private var showingPayment = false

	
	var body: some View {
		VStack {
			HStack {
		Button("<") {
			dismiss()
		}.frame(width: 30, height: 30, alignment: .topLeading)
		.font(.title)
			Spacer()
			}
			
			VStack {
				Text(course.name)
				Text(course.description)
				HStack {
					Text("$" + String(course.cost))
					Text("number of hours : " + String(course.hours))
				}
				
				Button("purchase") {
						showingPayment.toggle()
					
				}.frame(width: 200, height: 30, alignment: .topLeading)
					.font(.title)
			}
			Spacer()
		}

		.sheet(isPresented: $showingPayment) {
//			PaymentView(course: course)
			CreditCardView()
		}
		
	}
}


struct PaymentView: View {
	let course: Course
	@Environment(\.dismiss) var dismiss

	
	var body: some View {
		HStack {
			Button("<") {
				dismiss()
			}.frame(width: 30, height: 30, alignment: .topLeading)
				.font(.title)
			Spacer()
		}
		Text("in payments. give me ur credit card.")
	}
}
