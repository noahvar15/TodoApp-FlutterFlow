import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/add_task_widget.dart';
import '/components/task_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'tasks_model.dart';
export 'tasks_model.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({super.key});

  static String routeName = 'tasks';
  static String routePath = '/tasks';

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  late TasksModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TasksModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.apiResultwy1 = await GetQuoteCall.call();

      if ((_model.apiResultwy1?.succeeded ?? true)) {
        _model.quoteText = GetQuoteCall.quote(
          (_model.apiResultwy1?.jsonBody ?? ''),
        )!;
        _model.quoteAuthor = GetQuoteCall.author(
          (_model.apiResultwy1?.jsonBody ?? ''),
        )!;
        safeSetState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: Color(0xFFFF0005),
          ),
        );
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Padding(
                    padding: MediaQuery.viewInsetsOf(context),
                    child: AddTaskWidget(),
                  ),
                );
              },
            ).then((value) => safeSetState(() {}));
          },
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          elevation: 0.0,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondary,
              borderRadius: BorderRadius.circular(50.0),
              border: Border.all(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            child: Icon(
              Icons.add_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
          ),
        ),
        body: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 400.0,
            ),
            decoration: BoxDecoration(),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 24.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Tasks',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                        FlutterFlowIconButton(
                          borderRadius: 8.0,
                          buttonSize: 40.0,
                          icon: Icon(
                            Icons.logout,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 30.0,
                          ),
                          onPressed: () async {
                            GoRouter.of(context).prepareAuthEvent();
                            await authManager.signOut();
                            GoRouter.of(context).clearRedirectLocation();

                            context.goNamedAuth(
                                LoginWidget.routeName, context.mounted);
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<List<TasksRecord>>(
                      stream: queryTasksRecord(
                        queryBuilder: (tasksRecord) => tasksRecord
                            .where(
                              'user',
                              isEqualTo: currentUserReference,
                            )
                            .where(
                              'completed',
                              isEqualTo: false,
                            ),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        List<TasksRecord> listViewTasksRecordList =
                            snapshot.data!;

                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewTasksRecordList.length,
                          separatorBuilder: (_, __) => SizedBox(height: 12.0),
                          itemBuilder: (context, listViewIndex) {
                            final listViewTasksRecord =
                                listViewTasksRecordList[listViewIndex];
                            return InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  DetailsWidget.routeName,
                                  queryParameters: {
                                    'taskDoc': serializeParam(
                                      listViewTasksRecord,
                                      ParamType.Document,
                                    ),
                                  }.withoutNulls,
                                  extra: <String, dynamic>{
                                    'taskDoc': listViewTasksRecord,
                                  },
                                );
                              },
                              child: TaskWidget(
                                key: Key(
                                    'Key5cs_${listViewIndex}_of_${listViewTasksRecordList.length}'),
                                tasksDoc: listViewTasksRecord,
                                checkAction: () async {
                                  await listViewTasksRecord.reference
                                      .update(createTasksRecordData(
                                    completed: true,
                                  ));
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 0.0),
                      child: Text(
                        _model.quoteText,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          12.0, 12.0, 12.0, 65.0),
                      child: Text(
                        _model.quoteAuthor,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                  ),
                ].divide(SizedBox(height: 12.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
