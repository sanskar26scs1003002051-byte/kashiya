import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import './widgets/student_list_widget.dart';
import './widgets/vak_question_widget.dart';
import './widgets/vak_results_widget.dart';

enum VAKType { visual, auditory, kinesthetic, untested }

class StudentModel {
  final String id;
  final String name;
  final String rollNumber;
  final String avatarUrl;
  final String semanticLabel;
  VAKType vakType;
  int visualScore;
  int auditoryScore;
  int kinestheticScore;

  StudentModel({
    required this.id,
    required this.name,
    required this.rollNumber,
    required this.avatarUrl,
    required this.semanticLabel,
    this.vakType = VAKType.untested,
    this.visualScore = 0,
    this.auditoryScore = 0,
    this.kinestheticScore = 0,
  });

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'] as String,
      name: map['name'] as String,
      rollNumber: map['rollNumber'] as String,
      avatarUrl: map['avatarUrl'] as String,
      semanticLabel: map['semanticLabel'] as String,
      vakType: _vakFromString(map['vakType'] as String),
      visualScore: map['visualScore'] as int,
      auditoryScore: map['auditoryScore'] as int,
      kinestheticScore: map['kinestheticScore'] as int,
    );
  }

  static VAKType _vakFromString(String v) {
    switch (v) {
      case 'visual':
        return VAKType.visual;
      case 'auditory':
        return VAKType.auditory;
      case 'kinesthetic':
        return VAKType.kinesthetic;
      default:
        return VAKType.untested;
    }
  }
}

class VAKQuestion {
  final String question;
  final String visualOption;
  final String auditoryOption;
  final String kinestheticOption;

  const VAKQuestion({
    required this.question,
    required this.visualOption,
    required this.auditoryOption,
    required this.kinestheticOption,
  });
}

class VAKTestScreen extends StatefulWidget {
  const VAKTestScreen({super.key});

  @override
  State<VAKTestScreen> createState() => _VAKTestScreenState();
}

class _VAKTestScreenState extends State<VAKTestScreen> {
  int _selectedClassIndex = 0;
  StudentModel? _activeStudent;
  int _currentQuestion = 0;
  bool _showResults = false;
  final Map<int, int> _answers = {};

  final List<String> _classNames = [
    'Grade 9-A — Mathematics',
    'Grade 10-B — Physics',
    'Grade 11-C — Chemistry',
    'Grade 8-D — English Lit',
  ];

  final List<Map<String, dynamic>> _studentMaps = [
    {
      'id': 's01',
      'name': 'Arjun Mehta',
      'rollNumber': '01',
      'avatarUrl':
          'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg',
      'semanticLabel':
          'Young Indian male student with short dark hair wearing school uniform',
      'vakType': 'visual',
      'visualScore': 9,
      'auditoryScore': 4,
      'kinestheticScore': 2,
    },
    {
      'id': 's02',
      'name': 'Priya Patel',
      'rollNumber': '02',
      'avatarUrl':
          'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg',
      'semanticLabel':
          'Young Indian female student with long dark hair smiling',
      'vakType': 'auditory',
      'visualScore': 3,
      'auditoryScore': 10,
      'kinestheticScore': 2,
    },
    {
      'id': 's03',
      'name': 'Rahul Singh',
      'rollNumber': '03',
      'avatarUrl':
          'https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg',
      'semanticLabel': 'Teenage male student with glasses and casual clothing',
      'vakType': 'kinesthetic',
      'visualScore': 2,
      'auditoryScore': 3,
      'kinestheticScore': 10,
    },
    {
      'id': 's04',
      'name': 'Ananya Sharma',
      'rollNumber': '04',
      'avatarUrl':
          'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg',
      'semanticLabel': 'Young female student with braided hair in classroom',
      'vakType': 'visual',
      'visualScore': 8,
      'auditoryScore': 4,
      'kinestheticScore': 3,
    },
    {
      'id': 's05',
      'name': 'Karan Verma',
      'rollNumber': '05',
      'avatarUrl':
          'https://images.pexels.com/photos/3771089/pexels-photo-3771089.jpeg',
      'semanticLabel': 'Young male student in blue shirt holding textbooks',
      'vakType': 'untested',
      'visualScore': 0,
      'auditoryScore': 0,
      'kinestheticScore': 0,
    },
    {
      'id': 's06',
      'name': 'Nisha Gupta',
      'rollNumber': '06',
      'avatarUrl':
          'https://images.pexels.com/photos/1036623/pexels-photo-1036623.jpeg',
      'semanticLabel':
          'Female student with shoulder-length hair wearing glasses',
      'vakType': 'untested',
      'visualScore': 0,
      'auditoryScore': 0,
      'kinestheticScore': 0,
    },
    {
      'id': 's07',
      'name': 'Rohit Joshi',
      'rollNumber': '07',
      'avatarUrl':
          'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg',
      'semanticLabel':
          'Teenage male student with curly hair in outdoor setting',
      'vakType': 'auditory',
      'visualScore': 3,
      'auditoryScore': 9,
      'kinestheticScore': 3,
    },
    {
      'id': 's08',
      'name': 'Meera Nair',
      'rollNumber': '08',
      'avatarUrl':
          'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=200',
      'semanticLabel':
          'South Indian female student with dark hair and traditional earrings',
      'vakType': 'kinesthetic',
      'visualScore': 4,
      'auditoryScore': 2,
      'kinestheticScore': 9,
    },
  ];

  late List<StudentModel> _students;

  static const List<VAKQuestion> _questions = [
    VAKQuestion(
      question: 'When learning something new, you prefer to:',
      visualOption: 'Read notes or watch a diagram',
      auditoryOption: 'Listen to an explanation or discussion',
      kinestheticOption: 'Try it out hands-on or through practice',
    ),
    VAKQuestion(
      question: 'When you need to remember a phone number, you:',
      visualOption: 'Picture it written down in your mind',
      auditoryOption: 'Repeat it out loud several times',
      kinestheticOption: 'Write it down on paper or type it',
    ),
    VAKQuestion(
      question: 'In a classroom, you learn best when:',
      visualOption: 'There are diagrams, charts, and visual aids',
      auditoryOption: 'The teacher explains verbally with examples',
      kinestheticOption: 'You do experiments or practical activities',
    ),
    VAKQuestion(
      question: 'When you are bored, you tend to:',
      visualOption: 'Doodle or look around at your surroundings',
      auditoryOption: 'Hum, tap your foot, or talk to someone',
      kinestheticOption: 'Fidget, move around, or do something physical',
    ),
    VAKQuestion(
      question: 'When solving a problem, you prefer to:',
      visualOption: 'Draw a diagram or write it out visually',
      auditoryOption: 'Talk through it with someone aloud',
      kinestheticOption: 'Work through it step by step physically',
    ),
    VAKQuestion(
      question: 'When reading for pleasure, you:',
      visualOption: 'Visualize the scenes vividly in your mind',
      auditoryOption: 'Hear the characters\' voices as you read',
      kinestheticOption: 'Get emotionally involved in the story',
    ),
    VAKQuestion(
      question: 'When meeting new people, you remember them by:',
      visualOption: 'Their face and appearance',
      auditoryOption: 'Their name and the sound of their voice',
      kinestheticOption: 'The feeling you got from them',
    ),
    VAKQuestion(
      question: 'You prefer instructions that are:',
      visualOption: 'Written with diagrams or flowcharts',
      auditoryOption: 'Spoken clearly step by step',
      kinestheticOption: 'Demonstrated while you follow along',
    ),
    VAKQuestion(
      question: 'When concentrating, you are most distracted by:',
      visualOption: 'Untidiness or movement around you',
      auditoryOption: 'Noises or people talking nearby',
      kinestheticOption: 'Physical discomfort or restlessness',
    ),
    VAKQuestion(
      question: 'You express yourself best by:',
      visualOption: 'Drawing or writing your ideas down',
      auditoryOption: 'Speaking them out loud to others',
      kinestheticOption: 'Acting them out or using gestures',
    ),
    VAKQuestion(
      question: 'When giving directions, you:',
      visualOption: 'Draw a map or point to a visual reference',
      auditoryOption: 'Give verbal turn-by-turn instructions',
      kinestheticOption: 'Walk with the person to show them',
    ),
    VAKQuestion(
      question: 'You find it easiest to remember:',
      visualOption: 'Faces and places you have seen',
      auditoryOption: 'Songs, jokes, and conversations',
      kinestheticOption: 'Things you have done or experienced',
    ),
    VAKQuestion(
      question: 'When studying for an exam, you prefer to:',
      visualOption: 'Use colour-coded notes and mind maps',
      auditoryOption: 'Record summaries and listen back',
      kinestheticOption: 'Rewrite notes and practise past papers',
    ),
    VAKQuestion(
      question: 'You are most comfortable when:',
      visualOption: 'Your workspace is neat and visually organised',
      auditoryOption: 'There is background music or ambient sound',
      kinestheticOption: 'You can move around or take frequent breaks',
    ),
    VAKQuestion(
      question: 'When buying a new product, you are most influenced by:',
      visualOption: 'How it looks and its packaging',
      auditoryOption: 'What others say or a recommendation',
      kinestheticOption: 'How it feels when you touch or use it',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _students = _studentMaps.map(StudentModel.fromMap).toList();
  }

  void _startTest(StudentModel student) {
    setState(() {
      _activeStudent = student;
      _currentQuestion = 0;
      _answers.clear();
      _showResults = false;
    });
  }

  void _answerQuestion(int choice) {
    setState(() {
      _answers[_currentQuestion] = choice;
      if (_currentQuestion < _questions.length - 1) {
        _currentQuestion++;
      } else {
        _submitTest();
      }
    });
  }

  void _submitTest() {
    int v = 0, a = 0, k = 0;
    _answers.forEach((_, choice) {
      if (choice == 0) {
        v++;
      } else if (choice == 1) {
        a++;
      } else {
        k++;
      }
    });
    final student = _activeStudent!;
    student.visualScore = v;
    student.auditoryScore = a;
    student.kinestheticScore = k;
    if (v >= a && v >= k) {
      student.vakType = VAKType.visual;
    } else if (a >= v && a >= k) {
      student.vakType = VAKType.auditory;
    } else {
      student.vakType = VAKType.kinesthetic;
    }
    setState(() {
      _showResults = true;
    });
  }

  void _closeTest() {
    setState(() {
      _activeStudent = null;
      _showResults = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF),
      body: SafeArea(
        bottom: false,
        child: isTablet && _activeStudent != null
            ? _buildTabletTestLayout()
            : _buildPhoneLayout(),
      ),
    );
  }

  Widget _buildPhoneLayout() {
    if (_activeStudent != null) {
      return _showResults
          ? VAKResultsWidget(student: _activeStudent!, onClose: _closeTest)
          : VAKQuestionWidget(
              student: _activeStudent!,
              question: _questions[_currentQuestion],
              questionIndex: _currentQuestion,
              totalQuestions: _questions.length,
              selectedAnswer: _answers[_currentQuestion],
              onAnswer: _answerQuestion,
              onBack: _currentQuestion > 0
                  ? () => setState(() => _currentQuestion--)
                  : null,
            );
    }
    return _buildStudentListView();
  }

  Widget _buildTabletTestLayout() {
    return Row(
      children: [
        SizedBox(width: 320, child: _buildStudentListView(compact: true)),
        Container(width: 1, color: const Color(0xFFEDE9FF)),
        Expanded(
          child: _showResults
              ? VAKResultsWidget(student: _activeStudent!, onClose: _closeTest)
              : VAKQuestionWidget(
                  student: _activeStudent!,
                  question: _questions[_currentQuestion],
                  questionIndex: _currentQuestion,
                  totalQuestions: _questions.length,
                  selectedAnswer: _answers[_currentQuestion],
                  onAnswer: _answerQuestion,
                  onBack: _currentQuestion > 0
                      ? () => setState(() => _currentQuestion--)
                      : null,
                ),
        ),
      ],
    );
  }

  Widget _buildStudentListView({bool compact = false}) {
    final testedCount = _students
        .where((s) => s.vakType != VAKType.untested)
        .length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: Row(
            children: [
              if (!compact) ...[
                GestureDetector(
                  onTap: () => context.go(AppRoutes.dashboardScreen),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(15),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: 'arrow_back_rounded',
                        color: const Color(0xFF1A1A2E),
                        size: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  'VAK Test',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: const Color(0xFF1A1A2E),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFD0CCF0)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: _selectedClassIndex,
                isExpanded: true,
                items: _classNames.asMap().entries.map((e) {
                  return DropdownMenuItem(
                    value: e.key,
                    child: Text(
                      e.value,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                }).toList(),
                onChanged: (v) => setState(() => _selectedClassIndex = v!),
                icon: CustomIconWidget(
                  iconName: 'expand_more',
                  color: AppTheme.primary,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'psychology',
                  color: AppTheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$testedCount of ${_students.length} students tested',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      LinearProgressIndicator(
                        value: testedCount / _students.length,
                        backgroundColor: Colors.white,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppTheme.primary,
                        ),
                        minHeight: 4,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: StudentListWidget(
            students: _students,
            onStartTest: _startTest,
          ),
        ),
      ],
    );
  }
}
